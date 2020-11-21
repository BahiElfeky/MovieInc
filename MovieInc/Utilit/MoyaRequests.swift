//
//  MoyaRequests.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Moya
import SwiftyJSON


//MoyaProvider is like a manager or the main object to make requests with moya
extension MoyaProvider {
    //1- if there was an error with JSONDecoder().decode  (example: the data is not in correct way, swift error)
    //2- if the reponse wasn't 200 then server responded with an error (example: no user with that email)
    //3- if there was an error with moya request (example: no internet)
    //4- errors: -1 error from swift decoding, -2 error from backend, -3 error from Moya/Alamofire
    //Return Object and Data when success
    func BRequest<T: Decodable>(target: Target, onSuccess: @escaping (T, Data, Int?, [AnyHashable : Any]?) -> (), onError: @escaping (NSError, Int?) -> ()) {
        if Connectivity.isConnectedToInternet() == false {
            onError(NSError(domain: "Please Check Your Internet Connection", code: -1, userInfo: nil), nil)
            return
        }
        self.request(target) { (result) in
            print("///////////////////")
            print(target)
            print("///////////////////")
            switch result {
            case .success(let response):
                //print(JSON(response.data)
                DebugServices.DebugResponse(response: response, MoyaService: "\(target)")
                let responseStatusCode = response.statusCode
                let responseHeaders = response.response?.allHeaderFields
                if response.statusCode == 200 {
                    
                    do {
                        
                        let object = try JSONDecoder().decode(T.self, from: response.data)
                        onSuccess(object, response.data, responseStatusCode, responseHeaders)
                    } catch {
                        print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                        onError(NSError(domain: error.localizedDescription, code: -2, userInfo: nil), responseStatusCode) //1
                    }
                } else {
                    do {
                        let errorResponseObject = try JSONDecoder().decode(ServiceErrorTwo.self, from: response.data)
                        let errorString = errorResponseObject.message ?? ""
                        onError(NSError(domain: errorString, code: -3, userInfo: nil), errorResponseObject.code ?? -100) //2
                    } catch {
                        print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                        
                        do {
                            
                            let errorResponseObject = try JSONDecoder().decode(ServiceError.self, from: response.data)
                            var errorString = ""
                            errorResponseObject.details?.forEach {
                                let str = "\($0.dataPath?.replacingOccurrences(of: ".", with: "") ?? String()) \($0.message ?? String())\n"
                                errorString += str
                            }
                            onError(NSError(domain: errorString, code: -4, userInfo: nil), errorResponseObject.code ?? -100) //2
                            
                        } catch {
                            print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                            let message = JSON(response.data)["message"].stringValue
                            let code = JSON(response.data)["code"].intValue
                            onError(NSError(domain: message, code: -5, userInfo: nil), code) //2
                        }
                    }
                }
            case .failure(let error):
                print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error.localizedDescription)")
                onError(NSError(domain: error.localizedDescription, code: -6, userInfo: nil), nil) //3
            }
        }
    }
    //Return Data when success
    func BRequest(target: Target, onSuccess: @escaping (Data, Int) -> (), onError: @escaping (NSError, Int?) -> ()) {
        if Connectivity.isConnectedToInternet() == false {
            onError(NSError(domain: "Please Check Your Internet Connection", code: -1, userInfo: nil), nil)
            return
        }
        self.request(target) { (result) in
            switch result {
            case .success(let response):
                
                DebugServices.DebugResponse(response: response, MoyaService: "\(#function)")
                let responseStatusCode = response.statusCode
                
                if response.statusCode == 200 {
                    do {
                        onSuccess(response.data, responseStatusCode)
                    } catch {
                        print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                        onError(NSError(domain: error.localizedDescription, code: -2, userInfo: nil), responseStatusCode)
                    }
                } else {
                    do {
                        let errorResponseObject = try JSONDecoder().decode(ServiceErrorTwo.self, from: response.data)
                        var errorString = errorResponseObject.message ?? ""
                        onError(NSError(domain: errorString, code: -3, userInfo: nil), errorResponseObject.code ?? -100) //2
                    } catch {
                        print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                        
                        do {
                            
                            let errorResponseObject = try JSONDecoder().decode(ServiceError.self, from: response.data)
                            var errorString = ""
                            errorResponseObject.details?.forEach {
                                let str = "\($0.dataPath?.replacingOccurrences(of: ".", with: "") ?? String()) \($0.message ?? String())\n"
                                errorString += str
                            }
                            onError(NSError(domain: errorString, code: -4, userInfo: nil), errorResponseObject.code ?? -100) //2
                            
                        } catch {
                            print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                            let message = JSON(response.data)["message"].stringValue
                            let code = JSON(response.data)["code"].intValue
                            onError(NSError(domain: message, code: -5, userInfo: nil), code) //2
                        }
                    }
                    
                }
            case .failure(let error):
                print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error.localizedDescription)")
                onError(NSError(domain: error.localizedDescription, code: -6, userInfo: nil), nil)
            }
        }
    }
    //Return nothing when success
    func BRequest(target: Target, onSuccess: @escaping () -> (), onError: @escaping (NSError, Int?) -> ()) {
        if Connectivity.isConnectedToInternet() == false {
            onError(NSError(domain: "Please Check Your Internet Connection", code: -1, userInfo: nil), nil)
            return
        }
        self.request(target) { (result) in
            switch result {
            case .success(let response):
                
                DebugServices.DebugResponse(response: response, MoyaService: "\(#function)")
                let responseStatusCode = response.statusCode
                
                if response.statusCode == 200 {
                    do {
                        onSuccess()
                    } catch {
                        print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                        onError(NSError(domain: error.localizedDescription, code: -2, userInfo: nil), responseStatusCode)
                    }
                } else {
                    do {
                        let errorResponseObject = try JSONDecoder().decode(ServiceErrorTwo.self, from: response.data)
                        var errorString = errorResponseObject.message ?? ""
                        onError(NSError(domain: errorString, code: -3, userInfo: nil), errorResponseObject.code ?? -100) //2
                    } catch {
                        print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                        
                        do {
                            
                            let errorResponseObject = try JSONDecoder().decode(ServiceError.self, from: response.data)
                            var errorString = ""
                            errorResponseObject.details?.forEach {
                                let str = "\($0.dataPath?.replacingOccurrences(of: ".", with: "") ?? String()) \($0.message ?? String())\n"
                                errorString += str
                            }
                            onError(NSError(domain: errorString, code: -4, userInfo: nil), errorResponseObject.code ?? -100) //2
                            
                        } catch {
                            print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error)")
                            let message = JSON(response.data)["message"].stringValue
                            let code = JSON(response.data)["code"].intValue
                            onError(NSError(domain: message, code: -5, userInfo: nil), code) //2
                        }
                    }
                    
                }
            case .failure(let error):
                print("\nError in File: \(#file.split(separator: "/").last!), Func: \(#function), Line: \(#line) \n|>Target: \(target) \n|>Error: \(error.localizedDescription)")
                onError(NSError(domain: error.localizedDescription, code: -6, userInfo: nil), nil)
            }
        }
    }
}


