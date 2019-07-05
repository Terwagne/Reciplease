//
//  EdamamSessionTestsCase.swift
//  RecipleaseTests
//
//  Created by ISABELLE Terwagne on 27/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import XCTest


@testable import Reciplease

class EdamamSessionTestsCase: XCTestCase {
   
    func testUrlConstructRecipeSearch() {
        let ingredient =  "chicken+eggs+pasta"
        let apiKey = valueForAPIKey(named:"app_key")
        let apiId = valueForAPIKey(named:"app_id")
        XCTAssertEqual("https://api.edamam.com/search?q=\(ingredient)&app_id=\(apiId)&app_key=\(apiKey)", "https://api.edamam.com/search?q=chicken+eggs+pasta&app_id=9ecb9b3e&app_key=5e1c36a08f90bafe013d7deaaba7f411")
    }
    func testUrlConstructRecipeSearchWithLowFat() {
        let ingredient =  "chicken+eggs+pasta"
        let apiKey = valueForAPIKey(named:"app_key")
        let apiId = valueForAPIKey(named:"app_id")
        XCTAssertEqual("https://api.edamam.com/search?q=\(ingredient)&app_id=\(apiId)&app_key=\(apiKey)&diet=low-fat", "https://api.edamam.com/search?q=chicken+eggs+pasta&app_id=9ecb9b3e&app_key=5e1c36a08f90bafe013d7deaaba7f411&diet=low-fat")
    }
        
        func testSearchRecipesShouldPostFailedCallback () {
            
            let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
            let edamanSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
            let edamamService = EdamamService(edamamSession: edamanSessionFake)
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change ")
            edamamService.searchRecipes(ingredients: ["chicken+eggs+pasta"]){ (success, edamamRecipes) in
                
                //Then
                XCTAssertFalse(success)
                XCTAssertNil(edamamRecipes)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testSearchRecipesShouldPostFailedcallbackIfNoData () {// NoData
        // given
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)// CallbackIfError
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
       edamamService.searchRecipes(ingredients: ["chicken+eggs+pasta"]){ (success, edamamRecipes) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

func testSearchRecipesShouldPostFailedcallbackIfIncorrectResponse() { // IfIncorrectResponse
    //        // given
    let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData , error: nil)// CallbackIfError
    let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
    let edamamService = EdamamService(edamamSession: edamamSessionFake)
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change ")
    edamamService.searchRecipes(ingredients:["chicken+eggs+pasta"]){ (success, edamamRecipes) in
        //            //Then
        XCTAssertFalse(success)
        XCTAssertNil(edamamRecipes)
        expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
}
    func testSearchRecipesShouldPostSuccessCallbackIfResponseCorrectAndNildata() { //
        // given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil , error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
         edamamService.searchRecipes(ingredients: ["chicken+eggs+pasta"]){ (success, edamamRecipes) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testSearchRecipesShouldPostCallbackIfInCorrectData() {
        // given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        
        edamamService.searchRecipes(ingredients: ["chicken+eggs+pasta"]) { success, edamamRecipes in
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testSearchRecipesShouldPostFailedcallbackIfNoErrorAndCorrectData () {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData , error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
         edamamService.searchRecipes(ingredients: ["chicken+eggs+pasta"]) { (success, edamamRecipes) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testSearchRecipesWithLowFatShouldPostFailedCallbackIfnoData () {
        
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let edamanSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamanSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.searchRecipesWithLowFat(ingredients: ["chicken+eggs+pasta"]){ (success, edamamRecipes) in
            
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchRecipesWithLowFatShouldPostFailedcallbackIfIncorrectResponse() {
        // given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.searchRecipesWithLowFat(ingredients: ["chicken+eggs+pasta"]){ (success, edamamRecipes) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchRecipesWithLowFatShouldPostFailedcallbackIfresponseCorrectAndNildata() {
             // given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil , error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.searchRecipesWithLowFat(ingredients:["chicken+eggs+pasta"]){ (success, edamamRecipes) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testSearchRecipesWithLowFatShouldPostSuccessCallbackIfIncorrectData() {
        // given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData , error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        edamamService.searchRecipesWithLowFat(ingredients: ["chicken+eggs+pasta"]){ (success, edamamRecipes) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchRecipesWithLowFatShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        
        edamamService.searchRecipesWithLowFat(ingredients: ["chicken+eggs+pasta"]) { success, edamamRecipes in
            XCTAssertTrue(success)
            XCTAssertNotNil(edamamRecipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
//
    }
    
    

