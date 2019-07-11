//
//  UserDefault.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 04/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//
//
import Foundation

/// Save Ingredients with UserDefault
extension UserDefaults {
    private struct Keys {
        static let listOfIngredients = "listOfIngredients"
    }
    
    func updateIngredients() -> [String] {
        guard let list = UserDefaults.standard.array(forKey: Keys.listOfIngredients) as? [String] else { return [] }
        return list
    }
    
    func saveIngredients(listOfIngredients: [String]) {
        UserDefaults.standard.set(listOfIngredients, forKey: Keys.listOfIngredients)
        
    }
}
