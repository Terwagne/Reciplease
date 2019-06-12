//
//  RecipeSession.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 03/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire
class EdamamSession: EdamamProtocol {
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
    Alamofire.request(url).responseJSON { responseData in
        completionHandler(responseData)
    }
    }
}

