//
//  TempCor.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 13/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation


struct TempCor {
     var latitude:Double?
            var longitude:Double?
    var mapString : String?
    var mediaURL : String?
    var locationName : String?
    
    init(latitude:Double,longitude:Double) {
        self.latitude = latitude
        self.longitude = latitude
        self.mapString = "None"
        self.mediaURL = "NN"
        self.locationName = ""
    }
}
