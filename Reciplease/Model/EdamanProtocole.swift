//
//  EdamanProtocole.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 03/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire

protocol EdamamProtocol {

 func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}


        


