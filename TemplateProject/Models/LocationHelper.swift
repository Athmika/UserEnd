//
//  LocationHelper.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import CoreLocation
class LocationHelper:NSObject, CLLocationManagerDelegate
{
    var locationManager:CLLocationManager!
    var address: String? = nil
  
    func setup()
    {
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy - kCLLocationAccuracyBest
    }
    
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
                    println("\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)")
                    
                }
                
                
            }
            
        })
    }
    
     func getAddress()->String{
        setup()
    if let faddress = address
    {
       return (faddress)
    }
    else
    {
       return "Sorry, can't get your address"
    }
    
    
    }
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


