//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 02/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    
    var favoritesRecipes = RecipeEntity.fetchAll()
    var favoriteSelected: RecipeEntity?
     var recipeDetail: Recipe?
    
 override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomRecipeViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    favoritesRecipes = RecipeEntity.fetchAll()
    tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        favoritesRecipes = RecipeEntity.fetchAll()
        tableView.reloadData()
    }
    
    func updateFavoriteRecipeDetail(indexPath: IndexPath) {
//       let favoriteRecipeDetail = favoritesRecipes
        self.favoritesRecipes = [RecipeEntity.fetchAll()[indexPath.row]]
        self.performSegue(withIdentifier: "recipeDetail", sender: self)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailsVC = segue.destination as? RecipeDetailViewController {
        detailsVC.recipeDetail = recipeDetail
    }
}
   }
    extension FavoriteTableViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoritesRecipes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard indexPath.item < favoritesRecipes.count else { fatalError("Index out of rage")}
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomRecipeViewCell else { fatalError("Custom Cell can'nt be loaded")
                
            }
            let resultRecipe = favoritesRecipes[indexPath.row]
            customCell.favoritesRecipes = resultRecipe
            return customCell
            
}

}
extension FavoriteTableViewController: UITableViewDelegate {

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    updateFavoriteRecipeDetail(indexPath: indexPath)
}


}
