//
//  LogoutRequest.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 18/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation


struct LogoutRequest:Codable {
    let session:session
    
    struct session:Codable  {
        let id:String
        let expiration:String
    }

    
}
