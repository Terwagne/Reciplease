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
        let hrs = self / 60
        let min = self % 60
        return hrs > 0 ? String(format: "%1dh%02d mn", hrs, min) : String(format: "%1d mn", min)
    }
}
extension String {
    var convertStringTime: String {
        let hrs = Int(self)! / 60
        let min = Int(self)! % 60
        return hrs > 0 ? String(format: "%1dh%02d mn", hrs, min) : String(format: "%1d mn", min)
    }
}
