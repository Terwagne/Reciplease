//
//  Time.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 12/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation

extension Int {

// Cooking time
func secondsToString() -> String {
    let hours: Int = self / 3600
    let minutes: Int = (self / 60) % 60
   
    var timeInString: String = ""
    
    if hours > 0 {
        timeInString = String(hours) + "h"
    }
    
    if minutes > 0 {
        timeInString.append(String(minutes) + "m")
    }
    
    print("\(self) \(timeInString)")
    
    return timeInString
}
}
