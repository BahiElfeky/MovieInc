//
//  MoviesList.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Foundation


struct MoviesList: Codable{
    
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey{
        
        case movies = "results"
    }
}
