//
//  IngredientEntity.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 24/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import CoreData

class IngredientEntity: NSManagedObject {
        static var all: [IngredientEntity] {
            let request: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
            guard let ingredient = try? AppDelegate.viewContext.fetch(request) else {return []}
            return ingredient
        }
        static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [IngredientEntity] {
            let request: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
            guard let ingredient = try? viewContext.fetch(request) else { return [] }
            return ingredient
        }
        static func add(viewContext: NSManagedObjectContext = AppDelegate.viewContext, recipe: RecipeEntity, ingredientEntity : [Ingredient]) {
            for index in 0...ingredientEntity.count - 1 {
                let ingredient = IngredientEntity(context: viewContext)
                ingredient.text = ingredientEntity[index].text
                ingredient.recipeIngredient = recipe
            }
}
}
