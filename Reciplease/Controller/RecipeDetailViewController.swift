//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 12/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailViewController: UIViewController {
    ///  MARK: Outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDetailIngredientTableView: UITableView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var calorieLabel: UILabel!

    //    MARK : Propriety
    let edamamService = EdamamService()
    var edamanRecipes: EdamamRecipes?
    var ingredients = [String]()
    var recipeDetail: Recipe?
    var favoritesRecipes: [RecipeEntity] = RecipeEntity.fetchAll()
    var favorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if favorite == false {
            displayRecipe()
        } else {
            print(favoritesRecipes)
            displayFavoritesRecipes()
            recipeDetailIngredientTableView.dataSource = self
            recipeDetailIngredientTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if RecipeEntity.recipeAlreadyExist(label: recipeName.text!) {
            favoriteButton.tintColor = UIColor.green
        } else {
            favoriteButton.tintColor = .white
        }
    }

    ///    MARK: actions
    @IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
        print("add favorite button")
        if RecipeEntity.recipeAlreadyExist(label: recipeName.text!) {
            RecipeEntity.delete(label: recipeName.text!)
            favoriteButton.tintColor = .white
            _ = navigationController?.popViewController(animated: true)
        } else {
            guard let recipeDetail = recipeDetail else {return}
            RecipeEntity.add(recipe: recipeDetail)
            favoriteButton.tintColor = UIColor.green
            try? AppDelegate.viewContext.save()

        }
    }

    @IBAction func getRecipeDirection(_ sender: UIButton) {
        print("getRecipeDirection")
        if favorite == false {
            guard let recipeDetail = recipeDetail else {return}
            let urlSource = recipeDetail.url
            print("source : \(urlSource)")
            guard let url = URL(string: urlSource) else {return}
            UIApplication.shared.open(url)
        } else {
            guard let urlSource = favoritesRecipes[0].url else {return}
            guard let url = URL(string: urlSource) else {return}
            UIApplication.shared.open(url)
        }
    }

    func displayRecipe() {
        guard let recipeDetail = recipeDetail else {return}
        recipeName.text = recipeDetail.label
        let minuteTime = recipeDetail.totalTime.convertIntToTime
        if minuteTime == "" {
            timeLabel.text = "NA"
        } else {
            timeLabel.text = String("\(minuteTime)")
        }
        let yield = recipeDetail.yield
        if yield <= 0 {
            yieldLabel.text = "NA"
        } else {
            yieldLabel.text = "\( yield)"
        }
        let calories = recipeDetail.calories
        let caloriesInt = Int(calories)
        calorieLabel.text = "\(caloriesInt)" +  " calories"

        let image = recipeDetail.image
        guard let url = URL(string: image) else {return}

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.recipeImage.image = UIImage(data: data! as Data)
            }
        }
    }
    func displayFavoritesRecipes() {
        let name = favoritesRecipes[0].label
        recipeName.text = name
        let time = favoritesRecipes[0].time
        let minuteTime = time?.convertStringTime
        timeLabel.text = minuteTime!
        let yield = favoritesRecipes[0].yield
        yieldLabel.text = yield
        if let imageData = favoritesRecipes[0].image, let image = UIImage(data: imageData) {
            recipeImage.image = image
        } else {
            recipeImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            recipeImage.image = UIImage(named: "imageNotAvailable")
        }
        let calories = favoritesRecipes[0].calories
        let calorie = Int(calories)
        calorieLabel.text = "\(calorie)" +  " calories"
    }
}
// MARK: TableView
extension RecipeDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorite == true {
            let recipeIngredients = IngredientLineEntity.fetchAll()
            return recipeIngredients.count
        } else {
            guard let recipeIngredients = recipeDetail?.ingredientLines else {return 0}
            return recipeIngredients.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsDetailCell", for: indexPath)
        if favorite == true {
            let ingredientsLine = IngredientLineEntity.fetchAll()
            let instructions = ingredientsLine[indexPath.row]
            guard let name = instructions.name else {return cell}
            cell.textLabel?.text = name
            return cell
        } else {
            guard let recipeDetail = recipeDetail else { return UITableViewCell() }
            cell.textLabel?.text = "-" + recipeDetail.ingredientLines[indexPath.row]
            return cell
        }
    }
}
