//
//  GuestSessionResponse.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/21/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import Foundation


class SessionResponse: Codable {
    let sessionId: String?
    
    enum CodingKeys: String, CodingKey{
        
        case sessionId = "session_id"
    }
}
