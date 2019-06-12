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
    var recipes: [Recipe]?
    
       override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.reloadData()
        recipesTableView.register(UINib(nibName: "CustomRecipeViewCell", bundle: nil), forCellReuseIdentifier: "CustomRecipeViewCell")
    
        recipesTableView.reloadData()
    }
}
    // MARK: - Table view data source
extension RecipeTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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



}
