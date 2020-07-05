//
//  LoginResponse.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 02/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation

struct LoginResponse : Codable {
    let account:account
    let session:session
    
    struct account : Codable {
        let registered : Bool
        let key : String
    }
    
    
    struct session:Codable {
        let id:String
        let expiration:String
    }
    
}







