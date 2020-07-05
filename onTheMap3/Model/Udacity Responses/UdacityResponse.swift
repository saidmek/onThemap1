//
//  UdacityResponse.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 18/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation


struct UdacityResponse : Codable {
    let status:Int
    let error:String
}


extension UdacityResponse : LocalizedError {
    var errorDescription: String? {
        return error
    }
}
