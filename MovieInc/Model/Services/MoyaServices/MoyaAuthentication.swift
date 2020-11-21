//
//  MoyaAuthentication.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/21/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Moya

enum MoyaAuthentication {
    case createGuestSession
    case createRequestToken
    case createSession
}

extension MoyaAuthentication: TargetType {
    var baseURL: URL {
        return URL(string: ServicesConstants.Values.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .createGuestSession:
            return "authentication/guest_session/new"
        case .createRequestToken:
            return "authentication/token/new"
        case .createSession:
            return "authentication/session/new"
        }
    }
    
    var method: Method {
        switch self {
        case .createGuestSession, .createRequestToken:
            return .get
        case .createSession:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self{
        case .createGuestSession, .createRequestToken:
            
            let parameters: [String: Any] = [ServicesConstants.Keys.apiKey: ServicesConstants.Values.apiKey]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .createSession:
            
            let parameters: [String: Any] = [ServicesConstants.Keys.requestToken: ServicesConstants.Values.requestToken]
            print(ServicesConstants.Values.requestToken)
            return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: JSONEncoding.default, urlParameters: [ServicesConstants.Keys.apiKey: ServicesConstants.Values.apiKey])
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
