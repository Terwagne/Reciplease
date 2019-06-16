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

    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeDetailIngredientTableView: UITableView!
    
    @IBOutlet weak var getDirectionsButton: UIButton!
   
    @IBOutlet weak var yieldLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    let edamamService = EdamamService()
    var edamanRecipes:EdamamRecipes?
    var ingredients = [String]()
    var recipeDetail: Recipe?
    var favoritesRecipesDetail: [RecipeEntity]?
    var favorite:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFavoriteButton()
        displayRecipe()
       
       recipeDetailIngredientTableView.dataSource = self
        recipeDetailIngredientTableView.reloadData()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        favoritesRecipesDetail = RecipeEntity.fetchAll()
        displayFavorite()
    }

    @IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
        print("add favorite button")
        if favorite {
            RecipeEntity.delete(label: recipeDetail!.label)
        } else {
            RecipeEntity.add(recipe: recipeDetail!)
        }
        setFavoriteButton()
       
    }
    
  func setFavoriteButton() {
    guard recipeDetail != nil else{return}
    guard let recipeLabel = recipeDetail?.label else {return}

    if RecipeEntity.RecipeAlreadyExist(label: recipeLabel){
            favorite = true
            favoriteButton.tintColor = UIColor.green
        
        } else {
            print("save favorite")
        print (recipeDetail?.label as Any)
            favorite = false
            favoriteButton.tintColor = .white
    }
    
    print(favoritesRecipesDetail as Any)
        
    }
    @IBAction func getRecipeDirection(_ sender: UIButton) {
        print("getRecipeDirection")
        let urlSource = recipeDetail!.url
        print("source : \(urlSource)")
        guard let url = URL(string: urlSource) else {return}
        UIApplication.shared.open(url)
    }
   
    func displayRecipe()  {
        guard let recipeDetail = recipeDetail else {return}
        
        recipeName.text = recipeDetail.label
        if recipeDetail.totalTime == 0 {
            timeLabel.text = "NA"
        }else{
        timeLabel.text = String("\((recipeDetail.totalTime.secondsToString()))")
        }
        let yield = recipeDetail.yield
        yieldLabel.text = "\( yield)"
        let image = recipeDetail.image
                if let url = URL(string: image) {
                    if let data = try? Data(contentsOf: url as URL) {
                print(data)
                recipeImage.image = UIImage(data: data as Data)
            }
        } else {
            recipeImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            recipeImage.image = UIImage(named: "photo is not available")
        }
    }
    func displayFavorite() {
        guard let name = recipeDetail?.label else {return}
        recipeName.text = name
        guard let time = recipeDetail?.totalTime else {return}
        timeLabel.text = String(time.secondsToString())
        guard let yield = recipeDetail?.yield else {return}
        yieldLabel.text = String(yield)
        guard let image = recipeDetail?.image else {return}
        if let url = URL(string: image) {
            if let data = try? Data(contentsOf: url as URL) {
                recipeImage.image = UIImage(data: data as Data)
    }
}
    }
}
extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeIngredients = recipeDetail?.ingredientLines else {return 0}
        return recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsDetailCell", for: indexPath)
        guard let recipeDetail = recipeDetail else { return UITableViewCell() }
        cell.textLabel?.text = "-" + recipeDetail.ingredientLines[indexPath.row]
        return cell
}
}


