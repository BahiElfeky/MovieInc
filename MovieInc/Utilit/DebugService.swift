//
//  DebugService.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import SwiftyJSON
import Moya

class DebugServices{
    
    static func DebugResponse(response: Response, MoyaService: String) {
        print("\nstatusCode: \(response.statusCode),\nresponse: \(response)")
        //print("\nMoyaService: \(MoyaService),\n JSON: \(JSON(response.data))")
    }
    
}

