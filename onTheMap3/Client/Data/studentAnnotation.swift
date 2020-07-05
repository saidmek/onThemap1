//
//  studentAnnotation.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 19/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import Foundation
import MapKit
class studentAnnotation: NSObject,MKAnnotation {
    let title : String?
    let locationName : String?
    let discipline : String?
    let coordinate: CLLocationCoordinate2D
    
    
    
    init(title:String?,
        locationName:String?,
        discipline:String?,
        coordinate:CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
    }
    
    
    
    
    
    
    
    var subtitle:String? {
        return locationName
    }
    
    
    
    
}
