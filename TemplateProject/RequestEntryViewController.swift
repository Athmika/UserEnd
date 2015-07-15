//
//  RequestEntryViewController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit
import Parse
import MapKit
import CoreLocation

class RequestEntryViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate
{
    var photoTakingHelper: PhotoTakingHelper?
    let manager = CLLocationManager()
    var fimage:UIImage?
    var faddress: String?
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var ImagePreview: UIImageView!
    @IBOutlet weak var Button: UIButton!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Button.setTitle("Add image", forState: UIControlState.Normal)
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.startUpdatingLocation()

        
    }
    
    
    @IBAction func GetAddress(sender: UIButton) {
        manager.requestWhenInUseAuthorization()
        addressTextField.text  = faddress
        println(faddess)
       
    }
    
    func takePhoto(sender:UIButton) {
        var button = sender
        // instantiate photo taking class, provide callback for when photo  is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self,sender: button) { (image: UIImage?) in
            
            self.ImagePreview.image = image
            self.fimage = image
           }
    }
    
        
    @IBAction func Upload(sender: UIButton)
    {
      var name = nameTextField.text
      var phone = phoneTextField.text
      var address = addressTextField.text
        if ImagePreview.image == nil || name == nil
      {
        var alert = UIAlertController(title: "Alert", message: "All fields are required. Please add the missing information.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
      }
         else
      {
        
        let post = Post()
        post.name = name
        post.phone = phone
        post.address = address
        post.image = fimage
        post.uploadPhoto()
    }
     
    }
    
    @IBAction func AddPhotoButton(sender: UIButton)
    {
        takePhoto(sender)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //To make the field disapper
     func textFieldShouldReturn(textField: UITextField) -> Bool
     {
            nameTextField.resignFirstResponder()
            phoneTextField.resignFirstResponder()
            return true
        }

       /* func textFieldDidBeginEditing(textField: UITextField) {
            ScrollView.setContentOffset(CGPointMake(0, 3), animated: true)
        }*/
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                println("problem yo")
                
            } else {
                
                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark) {
                    
                    var subThoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare
                        
                    }
                    self.faddress = "\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                    
                }
                
            }
            
        })
    }
    }


//To use GPS


/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

extension RequestEntryViewController: CLLocationManagerDelegate
    
{
    
    
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        
        if let containsPlacemark = placemark {
            
            //stop updating location to save battery life
            
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            
            
            
            var latitude = containsPlacemark.location.coordinate.latitude
            
            var longitude = containsPlacemark.location.coordinate.longitude
            
            
            
            displayOnMap(latitude,Longitude: longitude)
            
        }
        
    }
    
    
    
    
    
func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            
            
            if (error != nil) {
                
                println("Reverse geocoder failed with error" + error.localizedDescription)
                
                return
                
            }
            
            
            
            if placemarks.count > 0 {
                
                let pm = placemarks[0] as! CLPlacemark
                
                self.displayLocationInfo(pm)
                
            } else {
                
                println("Problem with the data received from geocoder")
                
            }
            
        })
        
    }
    
    
    extension RequestEntryViewController: CLLocationManagerDelegate
        
    {
        
        
        
        func displayLocationInfo(placemark: CLPlacemark?) {
            
            if let containsPlacemark = placemark {
                
                //stop updating location to save battery life
                
                locationManager.stopUpdatingLocation()
                
                let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
                
                let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
                
                let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
                
                
                
                var latitude = containsPlacemark.location.coordinate.latitude
                
                var longitude = containsPlacemark.location.coordinate.longitude
                
                
                
                displayOnMap(latitude,Longitude: longitude)
                
            }
            
        }
        
        
        
        
        
        func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            
            CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
                
                
                
                if (error != nil) {
                    
                    println("Reverse geocoder failed with error" + error.localizedDescription)
                    
                    return
                    
                }
                
                
                
                if placemarks.count > 0 {
                    
                    let pm = placemarks[0] as! CLPlacemark
                    
                    self.displayLocationInfo(pm)
                    
                } else {
                    
                    println("Problem with the data received from geocoder")
                    
                }
                
            })
            
        }
        
        
        
        func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
            
            println("Error while updating location " + error.localizedDescription)
            
        }
        
        
        
        func displayOnMap(Latitude:CLLocationDegrees, Longitude: CLLocationDegrees)
            
        {
            
            let Location = CLLocation(latitude: Latitude, longitude: Longitude)
            
            let regionRadius: CLLocationDistance = 1000
            
            centerMapOnLocation(Location,regionRadius: regionRadius)
            
        }
        
        
        
        func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance)
            
        {
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
            
            map.setRegion(coordinateRegion, animated: true)
            
        }
        
        
        
}

