//
//  RecipeSearchViewController.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 02/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController {
    /// MARK: outlets
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var lowFatSwitch: UISwitch!

    /// MARK: properties
    var ingredients: [String] = []
    let userDefaults = UserDefaults.standard
    let edamamService = EdamamService()
    var edamamRecipes: EdamamRecipes?
    var lowFat: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredients = userDefaults.updateIngredients()
        ingredientsTableView.reloadData()
        toggleActivityIndicator(shown: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        toggleActivityIndicator(shown: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        toggleActivityIndicator(shown: false)
    }
    //  MARK : Actions
    @IBAction func lowFatSwitchOn(_ sender: Any) {
        if(sender as AnyObject).isOn == true {
            lowFat = true
        } else {
            lowFat = false
        }
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        guard let ingredientsText = ingredientsTextField.text else {return}
        if ingredientsText != "" {
            let list = ingredientsTextField.text!.transformToArray
            for ingredient in list {
                ingredients.append(ingredient)
            }
            print("\(ingredients)")
            ingredientsTableView.reloadData()
            ingredientsTextField.text = ""
            ingredients.sort()
            userDefaults.saveIngredients(listOfIngredients: ingredients)
            ingredientsTableView.reloadData()
        } else {
            alert(message: "Please indicate an ingredient")
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
            alert(message: "Please add ingredients")
        }
    }

    func searchRecipes() {
        print("requestSearchForRecipes")
        toggleActivityIndicator(shown: true)
        if lowFat == false {
            edamamService.searchRecipes(ingredients: ingredients) { (success, edamamRecipes) in
                if success {
                    print("success")
                    guard let edamamRecipes = edamamRecipes else {return}
                    self.edamamRecipes = edamamRecipes
                    self.performSegue(withIdentifier: "searchRecipesVC", sender: self)
                } else {
                    self.alert(message: "The search failed")
                }
            }
        } else {
            edamamService.searchRecipesWithLowFat(ingredients: ingredients) { (success, edamamRecipes) in
                if success {
                    print("success")
                    guard let edamamRecipes = edamamRecipes else {return}
                    self.edamamRecipes = edamamRecipes
                    self.performSegue(withIdentifier: "searchRecipesVC", sender: self)
                } else {
                    self.alert(message: "The search failed")
                }
            }
        }
    }
    ///MARK: animation
    func toggleActivityIndicator(shown: Bool) {
        searchForRecipesButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    /// MARK: navigation
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()}
    }
}
extension RecipeSearchViewController: UITextFieldDelegate {

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
    func alert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}
extension String {
    var transformToArray: [String] {
        return self.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ")
            .filter { !$0.isEmpty }
    }
}
