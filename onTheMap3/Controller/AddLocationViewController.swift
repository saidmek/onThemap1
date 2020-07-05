//
//  AddLocationViewController.swift
//  onTheMap3
//
//  Created by sid almekhlfi on 02/06/2020.
//  Copyright © 2020 saeed almekhlfi. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import MapKit



class AddLocationViewController: UIViewController  {
    
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    var locationCor = TempCor(latitude: 0, longitude: 0)
    @IBOutlet weak var AddLocationButton: UIButton!
    @IBOutlet weak var LinkedinTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail"{
            let detailVC = segue.destination as! AddLocationMapViewController
            detailVC.locationCor = locationCor
        }
    }
    @IBAction func AddLocationButton(_ sender: Any) {
        FinndingLocation(true)
        getCoordinate(addressString: LocationTextField.text ?? "") { (location, error) in
          if let location = location {
            self.FinndingLocation(false)
            if location.latitude >= 0 &&  location.longitude >= 0 && self.LocationTextField.text != "" && self.LinkedinTextField.text != ""  {
          self.locationCor.latitude = location.latitude
          self.locationCor.longitude = location.longitude
          self.locationCor.mapString = self.LinkedinTextField.text
          self.locationCor.mediaURL = self.LinkedinTextField.text
          self.locationCor.locationName = self.LocationTextField.text
          self.performSegue(withIdentifier: "MasterToDetail", sender:location)
                }
          else{ Alert.invalidLocation(on: self, message: error?.localizedDescription ?? "")}
            }
          else {}
        }
        }
    
    
    func geovode(Name: String,completion:@escaping([CLPlacemark]?,Error?)->Void){
        CLGeocoder().geocodeAddressString(Name) { (placeMarker, error) in
        guard let placMarker = placeMarker else {completion(nil,error)
                return }
        completion(placMarker,nil) }
        }
    
    
    
    func getCoordinate( addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D?, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {if let placemark = placemarks?[0] {let location = placemark.location!
        completionHandler(location.coordinate, nil)
                return }
            }
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)}
            }
    
    func FinndingLocation(_ Finnding:Bool){
        if Finnding{
            activityindicator.startAnimating()
        } else {
            activityindicator.stopAnimating()
        }
        
        AddLocationButton.isEnabled = !Finnding
        LinkedinTextField.isEnabled = !Finnding
        LocationTextField.isEnabled = !Finnding
        
    }


    
}
