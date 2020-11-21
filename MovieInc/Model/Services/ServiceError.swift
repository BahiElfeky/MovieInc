//
//  ServiceError.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Foundation

struct ServiceError: Codable {
    let details: [ServiceError.Detail]?
    let name, message: String?
    let code: Int?
    let stack: String?
    
    struct Detail: Codable {
        let dataPath, message, schemaPath, keyword: String?
        let params: ServiceError.Params?
    }
    
    struct Params: Codable {
        let limit: Int?
    }
}

struct ServiceErrorTwo: Codable {
    let name, message: String?
    let code: Int?
}

