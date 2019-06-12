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
            recipeTime.text = "\(time)"
            
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
      recipeImage.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.2, blue: 0.1960784314, alpha: 1)
      
    }
}

