//
//  AuthenticationServices.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/21/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Moya


class AuthenticationServices {
    static let sharedInstanace = AuthenticationServices()
    
    var authenticationProvider = MoyaProvider<MoyaAuthentication>(plugins: [NetworkLoggerPlugin()])
    
    func createSession( onSuccess: @escaping (SessionResponse) -> (), onError: @escaping (NSError) -> ()) {
        
        
        authenticationProvider.BRequest(target: .createSession, onSuccess: { (response: SessionResponse, data, _, _) in
            
            onSuccess(response)
            
        }) { (error, code) in
            onError(error)
        }
    }
    
    func createRequestToken( onSuccess: @escaping (RequestTokenResponse) -> (), onError: @escaping (NSError) -> ()) {
        
        
        authenticationProvider.BRequest(target: .createRequestToken, onSuccess: { (response: RequestTokenResponse, data, _, _) in
            
            onSuccess(response)
            
        }) { (error, code) in
            onError(error)
        }
    }
}
