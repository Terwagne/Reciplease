//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 04/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
class CustomRecipeViewCell: UITableViewCell {

    // MARK: outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
///MARK: propriety
    var recipe: Hit? {
        didSet {
            recipeName.text = recipe?.recipe.label
            guard let time = recipe?.recipe.totalTime  else {return}
            let total = time.convertIntToTime
            recipeTime.text = total
            guard let yield = recipe?.recipe.yield  else {return}
            if yield == 0 {
                recipeYield.text = "NA"
            } else {
                recipeYield.text = "\( yield)"
            }
            guard let ingredients = recipe?.recipe.ingredients[0].text else {return}
            recipeIngredients.text = ingredients
            guard let image = recipe?.recipe.image else {return}
            guard let url = URL(string: image) else {return}
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.recipeImage.image = UIImage(data: data! as Data)
                }
            }
            guard let calories = recipe?.recipe.calories else {return}
            let caloriesInt = Int(calories)
            calorieLabel.text = "\(caloriesInt)" + " calories"
        }
    }
    var favoritesRecipes: RecipeEntity? {
        didSet {
            recipeName.text = favoritesRecipes?.label
            if favoritesRecipes!.time == "" {
                recipeTime.text = "NA"
            } else {
                recipeTime.text = (favoritesRecipes?.time?.convertStringTime)!
            }
            recipeYield.text = favoritesRecipes?.yield
            if let ingredients = favoritesRecipes?.ingredient?.allObjects as? [IngredientEntity] {
                recipeIngredients.text = ingredients.map({$0.text ?? ""}).joined(separator: ", ")
            }
            guard let image = favoritesRecipes?.image else {return}
            recipeImage.image = UIImage(data: image as Data)
            guard let calories = favoritesRecipes?.calories else {return}
            let caloriesInt = Int(calories)
            calorieLabel.text = "\(caloriesInt)" + " calories"
        }
    }
}
