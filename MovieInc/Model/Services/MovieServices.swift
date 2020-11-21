//
//  MovieServices.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Moya


class MovieServices {
    static let sharedInstanace = MovieServices()
    
    var movieProvider = MoyaProvider<MoyaMovies>(plugins: [NetworkLoggerPlugin()])
    
    func getNowPlaying( onSuccess: @escaping (MoviesList) -> (), onError: @escaping (NSError) -> ()) {
        
        
        movieProvider.BRequest(target: .getNowPlaying(page: 1), onSuccess: { (list: MoviesList, data, _, _) in
            
            onSuccess(list)
            
        }) { (error, code) in
            onError(error)
        }
    }
    func getMovieDetails(movieId: Int, onSuccess: @escaping (Movie) -> (), onError: @escaping (NSError) -> ()) {
        
        movieProvider.BRequest(target: .movieDetails(id: movieId), onSuccess: { (movie: Movie, data, _, _) in
            
            onSuccess(movie)
            
        }) { (error, code) in
            onError(error)
        }
    }
    
    func getMovieRecommendations(movieId: Int, onSuccess: @escaping (MoviesList) -> (), onError: @escaping (NSError) -> ()) {
        
        movieProvider.BRequest(target: .getRecommendation(id: movieId), onSuccess: { (movie: MoviesList, data, _, _) in
            
            onSuccess(movie)
            
        }) { (error, code) in
            onError(error)
        }
    }
}
