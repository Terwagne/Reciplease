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
            if minuteTime == "" {
                recipeTime.text = "NA"
            }else{
            recipeTime.text = minuteTime
            }
            guard let yield = recipe?.recipe.yield  else {return}
            if yield == 0 {
                recipeYield.text = "NA"
            }else{
            recipeYield.text = "\( yield)"
            }
            guard let ingredients = recipe?.recipe.ingredients[0].text else {return}
            recipeIngredients.text = ingredients

            guard let image = recipe?.recipe.image else {return}
            
            let url = URL(string: image)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.recipeImage.image = UIImage(data: data! as Data)
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
            if favoritesRecipes!.time == "" {
                recipeTime.text = "NA"
            }else{
            recipeTime.text = favoritesRecipes?.time
            }
            recipeYield.text = favoritesRecipes?.yield
            
            if let ingredients = favoritesRecipes?.ingredient?.allObjects as? [IngredientEntity] {

                
                recipeIngredients.text = ingredients.map({$0.text ?? ""}).joined(separator: ", ")
            }
            guard let image = favoritesRecipes?.image else {return}
                   recipeImage.image = UIImage(data: image as Data)
           
        }
//    }
//
}

}


