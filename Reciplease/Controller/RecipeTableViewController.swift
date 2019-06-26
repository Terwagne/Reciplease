//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 02/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit

class RecipeTableViewController: UIViewController {
    //    outlets
    @IBOutlet var recipesTableView: UITableView!
    // MARK: - Properties
    
    let edamamService = EdamamService()
    var edamanRecipes:EdamamRecipes?
    var hits: [Hit]?
    var recipeDetail: Recipe?
    var calorie: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.reloadData()
        recipesTableView.register(UINib(nibName: "CustomRecipeViewCell", bundle: nil), forCellReuseIdentifier: "CustomRecipeViewCell")
        recipesTableView.reloadData()
    }
  
   
    
    func updateRecipeDetail(indexPath: IndexPath) {
        guard let recipeDetail = edamanRecipes?.hits[indexPath.row].recipe else {return}
        self.recipeDetail = recipeDetail
        self.performSegue(withIdentifier: "recipeDetail", sender: self)
    }
    
    //   navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        let segueName = "recipeDetail"
        if segue.identifier == segueName {
            let recipeDetailVC = segue.destination as! RecipeDetailViewController
            recipeDetailVC.recipeDetail = recipeDetail
            recipeDetailVC.favorite = false
            
        }
    }
}
// MARK: - Table view data source
extension RecipeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let edamamRecipes = edamanRecipes else { return 0 }
        return edamamRecipes.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomRecipeViewCell") as? CustomRecipeViewCell else {
            return UITableViewCell()}
        guard let edamamRecipes = edamanRecipes else { return UITableViewCell() }
        cell.recipe = edamamRecipes.hits[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        updateRecipeDetail(indexPath: indexPath)
        
        
    }
    
    
}
