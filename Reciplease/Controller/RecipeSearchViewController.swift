//
//  RecipeSearchViewController.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 02/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {

//    Outlets
    
  
    @IBOutlet weak var ingredientsTextField: UITextField!
   
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    
 // Properties

    var ingredients: [String] = []
    let userDefaults = UserDefaults.standard
    let edamamService = EdamamService()
    var edamamRecipes: EdamamRecipes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredients = userDefaults.updateIngredients()
        ingredientsTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
   @IBAction func addButtonPressed(_ sender: Any) {
    guard let ingredientsText = ingredientsTextField.text else {return}
    if ingredientsText != "" {
            ingredients.append(ingredientsText)
            print("\(ingredients)")
            ingredientsTableView.reloadData()
            ingredientsTextField.text = ""
            ingredients.sort()
            userDefaults.saveIngredients(listOfIngredients: ingredients)
           
            ingredientsTableView.reloadData()
            
            
        } else {
            Alert(message: "Please indicate an ingredient")
        }
}
    

    
    @IBAction func clearButtonPressed(_ sender: Any) {
        ingredients.removeAll()
          userDefaults.saveIngredients(listOfIngredients: ingredients)
        ingredientsTableView.reloadData()
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        if !ingredients.isEmpty {
            searchRecipes()
        } else {
            Alert(message: "Please add ingredients")
        }
    }
    
    func searchRecipes() {
        print("requestSearchForRecipes")
        edamamService.searchRecipes(ingredients: ingredients) { (success, edamamRecipes) in
            if success {
                print("success")
                guard let edamamRecipes = edamamRecipes else {return}
               self.edamamRecipes = edamamRecipes
   
    self.performSegue(withIdentifier: "searchRecipesVC", sender: self)
        }else{
    self.Alert(message: "The search failed")
    }
    }
    }
// MARK: - Navigation

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "searchRecipesVC" {
        if let edamamRecipes = edamamRecipes {
            if let successVC = segue.destination as? RecipeTableViewController {
                successVC.edamanRecipes = edamamRecipes
            }
        }
    }
    }
}
// MARK: - TableView DataSource
    
extension RecipeSearchViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ingredients.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
            let ingredient = ingredients[indexPath.row]
            cell.textLabel?.text = "- \(ingredient)"
            return cell
        }
    
 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        ingredients.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()}
}
}
extension RecipeSearchViewController : UITextFieldDelegate {
    
    func dismissKeyboard() {
        ingredientsTextField.resignFirstResponder()
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}
extension RecipeSearchViewController {
    func Alert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
}
    
}
