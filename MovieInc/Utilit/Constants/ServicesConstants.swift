//
//  ServicesConstants.swift
//  TheMovieManager
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation


class ServicesConstants{
    
    struct Keys {
        
        static var apiKey = "api_key"
        static var page = "page"
        static var sessionId = "session_id"
        static var requestToken = "request_token"
        
        
    }
    struct Values{
        
        static var baseUrl: String = "https://api.themoviedb.org/3"
        static var apiKey = "3aad1576e07fc1d49a0e297b1bda5937"
        static var sessionId = ""
        static var requestToken = ""
        static var imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    }
}
