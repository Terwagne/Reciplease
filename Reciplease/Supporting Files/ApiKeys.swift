//
//  ApiKeys.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 27/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    let value = plist?.object(forKey: keyname) as? String ?? ""
    return value
}
