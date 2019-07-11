//
//  EdamamProtocol.swift
//  Reciplease
//
//  Created by ISABELLE Terwagne on 03/06/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation

protocol EdamamProtocol {
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension EdamamProtocol {
    var urlStringApi: String {
        return ""
    }
}
