//
//  TimeTestCase.swift
//  RecipleaseTests
//
//  Created by ISABELLE Terwagne on 05/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import XCTest
@testable import Reciplease

class TimeTestCase: XCTestCase {

    func testWhenTimeIs100_shouldReturn1h40mn() {
        var time = "100"
        time = time.convertStringTime
        XCTAssertEqual(time,"1h40 mn")
        
    }
    
    func testWhenTimeIs30_shouldReturn30mn() {
        var time = "30"
        time = time.convertStringTime
        XCTAssertEqual(time,"30 mn")
        
    }
    
    
    func testWhenTimeIsInt100_shouldReturn1h40() {
        let time2 = 100.convertIntToTime

        XCTAssertEqual(time2, "1h40 mn")
}
    
    func testWhenTimeIsInt30_shouldReturn30mn() {
    let time2 = 30.convertIntToTime
    
    XCTAssertEqual(time2, "30 mn")
    
}
}
