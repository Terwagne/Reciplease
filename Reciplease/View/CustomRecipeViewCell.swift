//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 04/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
class CustomRecipeViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
   


    override func awakeFromNib() {
        super.awakeFromNib()
}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    
    var recipe: Hit? {
        didSet {
            recipeName.text = recipe?.recipe.label
            guard let time = recipe?.recipe.totalTime  else {return}
            let minuteTime = time.secondsToString()
            if minuteTime == "0" {
                recipeTime.text = "NA"
            }else{
            recipeTime.text = minuteTime
            }
            guard let yield = recipe?.recipe.yield  else {return}
            recipeYield.text = "\( yield)"
            
            guard let ingredients = recipe?.recipe.ingredients[0].text else {return}
            recipeIngredients.text = ingredients

            guard let image = recipe?.recipe.image else {return}
            if let url = URL(string: image) {
                if let data = try? Data(contentsOf: url as URL) {
                    recipeImage.image = UIImage(data: data as Data)
                } else {
                    defaultImage()
                }
            }
        }
    }
    
    func defaultImage() {
      recipeImage.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
      
    }
    
    
    var favoritesRecipes: RecipeEntity? {
        didSet {
            recipeName.text = favoritesRecipes?.label
            if favoritesRecipes!.time == "0" {
                recipeTime.text = "NA"
            }else{
            recipeTime.text = favoritesRecipes?.time
            }
            recipeYield.text = favoritesRecipes?.yield
            let recipeEntityObjects = favoritesRecipes?.ingredientLine?.allObjects as? [IngredientLineEntity]
            let ingredients = recipeEntityObjects?.description
            
            recipeIngredients.text = ingredients
        

            if let url = URL(string: favoritesRecipes!.image!) {
                if let data = try? Data(contentsOf: url as URL) {
                    recipeImage.image = UIImage(data: data as Data)
                } else {
                    defaultImage()
        }
    }
    
}

}
}

