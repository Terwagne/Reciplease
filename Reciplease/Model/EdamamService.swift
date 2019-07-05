//
//  RecipeService.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 03/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire

class EdamamService {
    
    private let edamamSession: EdamamProtocol
    
    init(edamamSession: EdamamProtocol = EdamamSession()) {
        self.edamamSession = edamamSession
        
    }
    
    //    MARK: Propriety
    
    let apiKey = valueForAPIKey(named:"app_key")
    let apiId = valueForAPIKey(named:"app_id")
   
    //  creation of the URL's for the requests
    func createSearchRecipesURL(ingredients: [String]) -> URL? {
        let parameters = ingredients.joined(separator: "+")
        let urlString = "https://api.edamam.com/search?q=\(parameters)&app_id=\(apiId)&app_key=\(apiKey)"
        let urlString2 = urlString.replacingOccurrences(of: " ", with: "")
        
        print(urlString2)
        guard let url = URL(string : urlString2) else { return nil }
        
        return url
        
    }
    
    func createSearchRecipesURLWithOptionLowFat(ingredients: [String]) -> URL? {
        let parameters = ingredients.joined(separator: "+")
        let urlString = "https://api.edamam.com/search?q=\(parameters)&app_id=\(apiId)&app_key=\(apiKey)&diet=low-fat"
        
        let urlString2 = urlString.replacingOccurrences(of: " ", with: "")
        
        print(urlString2)
        guard let url = URL(string : urlString2) else { return nil }
        
        return url
        
    }
    
    // Requests API
    func searchRecipes(ingredients: [String], completionHandler: @escaping (Bool, EdamamRecipes?) -> Void) {
        print(ingredients)
        guard let url = createSearchRecipesURL(ingredients: ingredients)else {return}
        
        edamamSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let edamamRecipes = try? JSONDecoder().decode(EdamamRecipes.self, from: data) else  {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, edamamRecipes)
        }
    }
    func searchRecipesWithLowFat(ingredients: [String], completionHandler: @escaping (Bool, EdamamRecipes?) -> Void) {
        print(ingredients)
        guard let url = createSearchRecipesURLWithOptionLowFat(ingredients: ingredients)else {return}
        
        edamamSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let edamamRecipes = try? JSONDecoder().decode(EdamamRecipes.self, from: data) else  {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, edamamRecipes)
        }
    }
    
}

