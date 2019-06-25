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
    
    @IBOutlet weak var deleteFavoriteBarButton: UIBarButtonItem!
    
    var favoritesRecipes = RecipeEntity.fetchAll()
    var favoriteSelected: [RecipeEntity?] = []
     var recipeDetail: Recipe?
    
 override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomRecipeViewCell", bundle: nil), forCellReuseIdentifier: "CustomRecipeViewCell")
    favoritesRecipes = RecipeEntity.fetchAll()
    tableView.reloadData()
    print (favoritesRecipes)
    }
    override func viewWillAppear(_ animated: Bool) {
        favoritesRecipes = RecipeEntity.fetchAll()
        tableView.reloadData()
    }
    
    func updateFavoriteRecipeDetail(indexPath: IndexPath) {
        self.favoritesRecipes = [RecipeEntity.fetchAll()[indexPath.row]]
        self.performSegue(withIdentifier: "recipeDetail", sender: self)
    }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailsVC = segue.destination as? RecipeDetailViewController {
        detailsVC.favoritesRecipes = favoritesRecipes
        detailsVC.favorite = true
    }
}
    

    @IBAction func deleteFavorites(_ sender: Any) {
       AlertDelete(message: "Are You sure to delete all favorites ?" )
        tableView.reloadData()
    }
    }

extension FavoriteTableViewController: UITableViewDataSource, UITableViewDelegate{

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoritesRecipes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomRecipeViewCell", for: indexPath) as? CustomRecipeViewCell else { fatalError("Custom Cell can'nt be loaded")
                
            }
            let resultRecipe = favoritesRecipes[indexPath.row]
            customCell.favoritesRecipes = resultRecipe
           
            return customCell
           
            
}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        updateFavoriteRecipeDetail(indexPath: indexPath)
}
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipe = favoritesRecipes[indexPath.row].label else {return}
            if RecipeEntity.recipeAlreadyExist(label: recipe) {
                RecipeEntity.delete(label: recipe)
                favoritesRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()}
    }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let label = UILabel()
        label.text = "Add some recipes in your favorites"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoritesRecipes.isEmpty ? 200: 0
    }
}
extension FavoriteTableViewController {
        func AlertDelete(message: String) {
            let alertVC = UIAlertController(title: "Warning !", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                RecipeEntity.deleteAll()
                self.favoritesRecipes.removeAll()
               self.tableView.reloadData()
            }))
                
            alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }    }
    


