//
//  Movie.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Foundation


struct Movie: Codable {
    
    let id: Int?
    let title: String?
    let vote: Int?
    let poster: String?
    let releaseDate: String?
    let overview: String?
    let genre: [Genre]?
    let voteAverage: Double?
    
    lazy var posterPath = "\(ServicesConstants.Values.imageBaseUrl)\(self.poster ?? String())"
    
    enum CodingKeys: String, CodingKey{
        case title, overview, id
        case vote = "vote_count"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case genre = "genres"
        case voteAverage = "vote_average"
    }
    
    struct Genre: Codable {
        let id: Int?
        let name: String?
        
        enum CodingKeys: String, CodingKey{
            case id, name
        }
    }
}
