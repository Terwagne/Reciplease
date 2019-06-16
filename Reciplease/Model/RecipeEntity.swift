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
        favoriteRecipe.image = recipe.image
        favoriteRecipe.url = recipe.url
    
        IngredientLineEntity.add(viewContext: viewContext, recipe: favoriteRecipe, ingredients: recipe.ingredientLines)
    
        try? viewContext.save()
}
    static func fetchRecipe (label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        guard let favoritesRecipes = try? viewContext.fetch(request) else {return []}
        return favoritesRecipes
    }
    
    static func RecipeAlreadyExist(viewContext: NSManagedObjectContext = AppDelegate.viewContext, label: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        if let _ = try? viewContext.fetch(request).first { return true }
        return false
    }
    static func delete(label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
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
