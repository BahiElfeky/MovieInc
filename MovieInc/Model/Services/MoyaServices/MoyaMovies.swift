//
//  MoyaMovies.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Moya

enum MoyaMovies{
    case getNowPlaying(page: Int)
    case movieDetails(id: Int)
    case getRecommendation(id: Int)
}

extension MoyaMovies: TargetType{
    var baseURL: URL {
        return URL(string: ServicesConstants.Values.baseUrl)!
    }
    
    var path: String {
        switch self {
            
        case .getNowPlaying:
            return "movie/now_playing"
        case .movieDetails(let id):
            return "movie/\(id)"
        case .getRecommendation(let id):
            return "movie/\(id)/recommendations"
        default:
            return ""
        }
        
    }
    
    var method: Method {
        switch self {
        case .getNowPlaying, .movieDetails, .getRecommendation:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getNowPlaying(let page):
            
            let parameters: [String: Any] = [ServicesConstants.Keys.page: page,
                                             ServicesConstants.Keys.apiKey: ServicesConstants.Values.apiKey]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .movieDetails, .getRecommendation:
        
        let parameters: [String: Any] = [ServicesConstants.Keys.apiKey: ServicesConstants.Values.apiKey]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
