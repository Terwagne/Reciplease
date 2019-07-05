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

    var convertIntToTime: String {
    let h = self / 60
    let m = self % 60
    return h > 0 ? String(format: "%1dh%02d mn", h, m) : String(format: "%1d mn", m)
}
}
    extension String {
    var convertStringTime: String {
        let h = Int(self)! / 60
        let m = Int(self)! % 60
        return h > 0 ? String(format: "%1dh%02d mn", h, m) : String(format: "%1d mn", m)
    }
       
        }
        

