//
//  RecipeObject.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 03/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire

struct EdamamRecipes: Decodable {
    let hits: [Hit]
}

// MARK: Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
    let calories: Double
    let dietLabels: [String]
}

// MARK: Ingredient
struct Ingredient: Decodable {
    let text: String
}
