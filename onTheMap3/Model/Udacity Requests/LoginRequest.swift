//
//  LoginRequest.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 02/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation

struct LoginRequest : Codable {
     let udacity : Udacity
    
    
  struct Udacity:Codable {
      let username : String
      let password : String
  }

}




