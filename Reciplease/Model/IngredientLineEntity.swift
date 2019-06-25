//
//  IngredientLineEntity.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 15/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import CoreData

class IngredientLineEntity: NSManagedObject {
    static var all: [IngredientLineEntity] {
        let request: NSFetchRequest<IngredientLineEntity> = IngredientLineEntity.fetchRequest()
        guard let ingredientLine = try? AppDelegate.viewContext.fetch(request) else {return []}
        return ingredientLine
    }
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientLineEntity] {
        let request: NSFetchRequest<IngredientLineEntity> = IngredientLineEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let ingredientLine = try? viewContext.fetch(request) else { return [] }
        return ingredientLine
        
}
    static func add(viewContext: NSManagedObjectContext = AppDelegate.viewContext, recipe: RecipeEntity, ingredientLineEntity: [String]) {
        for index in 0...ingredientLineEntity.count - 1 {
            let ingredient = IngredientLineEntity(context: viewContext)
            ingredient.name = ingredientLineEntity[index]
          
            ingredient.recipe = recipe
        }
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "IngredientLineEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        let _ = try? viewContext.execute(deleteRequest)
        try? viewContext.save()
    }
}


