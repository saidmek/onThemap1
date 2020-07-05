//
//  AddLocationMapViewController.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 12/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController , MKMapViewDelegate {
    var locationCor : TempCor?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishTapped: UIButton!
    override func viewDidLoad() {
         super.viewDidLoad()
          mapView.delegate = self
        let stusentA = studentAnnotation(title: "YOUR LOCATION",
                     locationName:locationCor?.locationName ,
                     discipline:"student",
                     coordinate: CLLocationCoordinate2D(latitude: locationCor?.latitude as! Double, longitude: locationCor?.longitude as! Double) )
        
        mapView.addAnnotation(stusentA)
        let initialLocation = CLLocation(latitude: locationCor?.latitude as! Double , longitude: locationCor?.longitude as! Double)
        mapView.centerToLocation(initialLocation)
        // Do any additional setup after loading the view.
    }
    
    


    @IBAction func FinnishTapped(_ sender: Any) {
        
        onThemapClient.createStudentLocation(firstName: "saeed", lastName: "saeed", latitude: locationCor?.latitude as! Double , longitude: locationCor?.longitude as! Double, mapString: locationCor?.mapString as! String , uniqueKey:"123", mediaURL:  locationCor?.mediaURL as! String) { (respnse, error) in
            if let respnose = respnse {
                print("u did it man")
                print(respnose.createdAt)
             
            } else {
                print("errrpr")
            }
        }
        
        
        
    }
    
    
 

}


private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}


