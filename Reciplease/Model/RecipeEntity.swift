//
//  RecipeEntity.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 14/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import CoreData

class RecipeEntity: NSManagedObject {
    static var all: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let favoritesRecipes = try? AppDelegate.viewContext.fetch(request) else {return []}
        return favoritesRecipes
    }
        static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let favoritesRecipes = try? viewContext.fetch(request) else { return [] }
        return favoritesRecipes
    }
    
    static func add(viewContext: NSManagedObjectContext = AppDelegate.viewContext, recipe: Recipe) {
        let favoriteRecipe = RecipeEntity(context: viewContext)
        favoriteRecipe.label = recipe.label
        favoriteRecipe.time =  String(recipe.totalTime)
        favoriteRecipe.yield = String(recipe.yield)
       
        let imageUrlString = recipe.image
        
        let imageUrl = URL(string: imageUrlString)!
        
        let imageData = try! Data(contentsOf: imageUrl)
        
       favoriteRecipe.image = imageData
        
        favoriteRecipe.url = recipe.url
        
       
        favoriteRecipe.calories = recipe.calories
       

        IngredientEntity.add(viewContext: viewContext, recipe: favoriteRecipe, ingredientEntity: recipe.ingredients)
        
        print(recipe.ingredients)
        
        IngredientLineEntity.add(viewContext: viewContext, recipe: favoriteRecipe, ingredientLineEntity: recipe.ingredientLines)
    
        try? viewContext.save()
}
    static func fetchRecipe (label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", label)
        guard let favoritesRecipes = try? viewContext.fetch(request) else {return []}
        return favoritesRecipes
    }
    
    static func recipeAlreadyExist(viewContext: NSManagedObjectContext = AppDelegate.viewContext, label: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", label)
        guard let recipeEntites = try? viewContext.fetch(request) else { return false }
        if recipeEntites.isEmpty { return false }
        return true
      
    }
    static func delete(label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", label)
        guard let favoritesRecipes = try? viewContext.fetch(request) else {return}
        guard let favoriteRecipe = favoritesRecipes.first else {return}
        viewContext.delete(favoriteRecipe)
        }
    
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        let _ = try? viewContext.execute(deleteRequest)
        try? viewContext.save()
    }
    
}
