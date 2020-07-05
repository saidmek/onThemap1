//
//  MapViewController.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 26/05/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController , MKMapViewDelegate {
      var locationCor = TempCor(latitude: 0, longitude: 0)
   var annotations = [MKPointAnnotation]()
           
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        data()
        self.mapView.addAnnotations(annotations)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func refreshTapped(_ sender: Any) {
           _ = onThemapClient.getStudents(completion: { (data, error) in
                      LocationModel.studentList = data
                      DispatchQueue.main.async {
                        self.data()
                       self.mapView.addAnnotations(self.annotations)
                                        }
                  })
       }
    
    
    func data(){
        
        _ = onThemapClient.getStudents { (data, error) in
                 
            LocationModel.studentList = data
            print( )
               for n in data {
                   
                let lat = CLLocationDegrees(n.latitude!)
                let long = CLLocationDegrees(n.longitude!)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let first = n.firstName!
                let mediaURL = n.mediaURL!
                   let annotation = MKPointAnnotation()
                   annotation.coordinate = coordinate
                   annotation.title = "\(first)"
                   annotation.subtitle = mediaURL
                   
                self.annotations.append(annotation)
               }
               
               
            self.mapView.addAnnotations(self.annotations)
              
                      }
        
    }
    
    
   
    @IBAction func add(_ sender: Any) {
      
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        onThemapClient.logOut {
            DispatchQueue.main.async {
            
                 self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
       var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView?.pinColor = .red
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        } else {
            
            pinView!.annotation = annotation
        }
        
        
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           if control == view.rightCalloutAccessoryView {
               let app = UIApplication.shared
               if let toOpen = view.annotation?.subtitle! {
                   app.openURL(URL(string: toOpen)!)
               }
           }
       }
    
    
    
    
    
    
    
    
    

}
