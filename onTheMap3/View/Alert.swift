//
//  Alert.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 16/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation
import UIKit

struct Alert  {
    static func  invalidLocation(on vc:UIViewController , message:String){
        let AlertVC = UIAlertController(title: "invalidLocation", message: message, preferredStyle: .alert)
               AlertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(AlertVC,animated: true)
    }
    
    
    static func showLoginFailure(on vc:UIViewController  , message:String){
        let AlertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        AlertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(AlertVC,animated: true)
    }
}
