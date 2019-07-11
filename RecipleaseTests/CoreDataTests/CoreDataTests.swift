//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by ISABELLE Terwagne on 28/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {
    
    //MARK: Properties
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: {(_, error) in
            XCTAssertNil(error)})
        return container
    }()
    
    //MARK: Helper Methods
    private func insertRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newRecipeItem = RecipeEntity(context: managedObjectContext)
        newRecipeItem.label = "Oodles of Pasta & Chicken"
        newRecipeItem.calories =  1137.34608
        newRecipeItem.yield = "4"
    }
    
    override func tearDown() {
        super.tearDown()
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
    }
    
    //MARK: UnitTests
    func testInsertManyRecipesItemInPersistentContainer() {
        for _ in 0 ..< 100 {
            insertRecipeItem(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    func testAddRecipes_whenAFavoriteRecipeIsAdd_thenArrayisNotEmpty() {
        let recipe = Recipe.init(uri: "www", label: "Oodles of Pasta & Chicken",
                                 image: "https://www.edamam.com/web-img/364/36437d38cce55c11ad6db1f0c47775ec.jpeg",
                                 source: "www", url: "www", yield: 4, ingredientLines: ["String"],
                                 ingredients: [Ingredient.init(text: "lemon")],
                                 totalTime: 300, calories: 340.00, dietLabels: [""])
        insertRecipeItem(into: mockContainer.viewContext)
        RecipeEntity.add(viewContext: mockContainer.viewContext, recipe: recipe)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(!RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).isEmpty)
    }
    
    func testFetchRecipe_whenAspecificRecipeIsPassed_thenShouldReturnAnArrayWithThisSpeficicRecipe() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        let recipe =  RecipeEntity.fetchRecipe(label: "Oodles of Pasta & Chicken",
                                               viewContext: mockContainer.viewContext)
        XCTAssertTrue(((recipe.first != nil)))
    }
    
    func testDeleteAllRecipesItemsInPersistentContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        RecipeEntity.deleteAll(viewContext: mockContainer.viewContext)
        XCTAssertEqual(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    func testFetchAll_whenEntityIsPassed_thenShouldReturnaNoEmptyArray() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(!RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).isEmpty)
    }
    
    func testCheckRecipeAllreadyExist_whenEntityIsPassed_thenCheckIfEntityIsinContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        print(RecipeEntity.fetchAll(viewContext: mockContainer.viewContext))
        XCTAssertTrue(RecipeEntity.recipeAlreadyExist(viewContext: mockContainer.viewContext,
                                                      label: "Oodles of Pasta & Chicken"))
    }
    
    func testCheckRecipeNotExist_whenEntityIsPassed_thenCheckIfEntityisnotinContainer() {
        XCTAssertFalse(RecipeEntity.recipeAlreadyExist(viewContext: mockContainer.viewContext, label: "") )
    }
    
    func testDelete_whenEntityIsDeleted_thenShouldReturnwuthoutThisEntity() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        RecipeEntity.delete(label: "Oodles of Pasta & Chicken", viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertFalse(RecipeEntity.recipeAlreadyExist(label: "Oodles of Pasta & Chicken"))
        XCTAssertNil(((RecipeEntity.fetchAll(viewContext: mockContainer.viewContext).first)))    }
    
    func testInsertManyIngredientItemInPersistentContainer() {
        for _ in 0 ..< 100 {
            insertRecipeItem(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    private func insertIngredientItem(into managedObjectContext: NSManagedObjectContext) {
        let newIngredient = IngredientEntity(context: managedObjectContext)
        newIngredient.text = "Lemon"
    }
    
    func testFetchIngredient_whenAnIngredientisPassed_thenShouldReturnAnArrayWithThisIngredient() {
        insertIngredientItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        //        IngredientEntity.fetchAll(viewContext: mockContainer.viewContext)
        XCTAssertTrue(((IngredientEntity.fetchAll(viewContext: mockContainer.viewContext).first != nil)))
    }
    
    private func insertIngredientLineItem(into managedObjectContext: NSManagedObjectContext) {
        let newIngredientLine = IngredientLineEntity(context: managedObjectContext)
        newIngredientLine.name = "Lemon"
    }
    
    func testFetchIngredientLine_whenAnIngredientLineisPassed_thenShouldReturnAnArrayWithThisIngredientLine() {
        insertIngredientLineItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        //        IngredientLineEntity.fetchAll(viewContext: mockContainer.viewContext)
        XCTAssertTrue(((IngredientLineEntity.fetchAll(viewContext: mockContainer.viewContext).first != nil)))
    }
    
    func testDeleteAllIngredientLineItemsInPersistentContainer() {
        insertIngredientLineItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        IngredientLineEntity.deleteAll(viewContext: mockContainer.viewContext)
        XCTAssertEqual(IngredientLineEntity.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
}
