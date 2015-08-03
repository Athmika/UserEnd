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

class RequestEntryViewController: UIViewController, UITextFieldDelegate,  UIPickerViewDelegate
{
    var photoTakingHelper: PhotoTakingHelper?
    var manager:CLLocationManager!
    let userAlert = UserAlert()
    var fimage:UIImage?
    var faddress: String?
    var ward: String?
    var dictionary = [String:Bool]()
    var segregatedArray: [String] = []
    
    
   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField:UITextField!
    
    @IBOutlet weak var ImagePreview: UIImageView!
    @IBOutlet weak var Button: UIButton!
    
    @IBOutlet weak var sendButtonForState: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func GetAddress(sender: UIButton) {
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
               
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
    self.sendButtonForState.enabled = false
      var name = nameTextField.text
      //var phone = phoneTextField.text
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
        var n: Int! = self.navigationController?.viewControllers?.count
        if self.navigationController?.viewControllers[n-2].title == "Segregated_waste"
        {
         post.isSegregated = true
          for (item, state)in dictionary
          {segregatedArray.append(item)}
        }
        else {post.isSegregated = false}
        post.isCompleted = false
        post.image = fimage
        post.isFeasible = false
        post.textSent = false
        post.array = segregatedArray
        post.name = name
        post.ward = ward
        post.phone = phone
        
        post.address = address
        post.uploadPhoto()
        
        userAlert.phone = phone
        userAlert.isFeasible = false
        userAlert.isCompleted = false
        userAlert.userConfirmed = false
        userAlert.textSent = false
        userAlert.saveInBackgroundWithBlock {
                (success, error) in
            
            if success == true {
        self.performSegueWithIdentifier("goToLoginController", sender: self)
            }
            else {
            ErrorHandling.defaultErrorHandler(error!)
            }
            
        }
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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func wardSegment(sender: UISegmentedControl) {
       ward = "\(segmentedControl.selectedSegmentIndex + 1)"
       
    }
    //To make the field disapper
    @IBOutlet weak var wardSegment: UISegmentedControl!
     func textFieldShouldReturn(textField: UITextField) -> Bool
     {
            nameTextField.resignFirstResponder()
            
            addressTextField.resignFirstResponder()
            return true
        }

       /* func textFieldDidBeginEditing(textField: UITextField) {
            ScrollView.setContentOffset(CGPointMake(0, 3), animated: true)
        }*/

   /* var wards = ["1","2","3","4","5","6"]
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return wards.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       
         ward = wards[row]
        return ward
    }
    
    */
    
    
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
        
        func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
        {
            
            var addressText = ""
            //println(locations)
            
            var userLocation:CLLocation = locations[0] as! CLLocation
           
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
                
                if (error != nil)
                {
                    println("There has been a problem")
                    println(error)
                    
                }
                else {
                    
                    if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark)
                    {
                        
                        if (p.subThoroughfare != nil)
                        {
                            addressText += p.subThoroughfare + " "
                        }
                        
                        if (p.thoroughfare != nil)
                        {
                           addressText += p.thoroughfare + " "
                        }
                        
                        if (p.subLocality != nil)
                        {
                            addressText += p.subLocality + " "
                        }
                        
                        if (p.subAdministrativeArea != nil)
                        {
                            addressText += p.subAdministrativeArea + " "
                        }
                        
                        if (p.postalCode != nil)
                        {
                           addressText += p.postalCode + " "
                        }
                        
                        
                       self.addressTextField.text = addressText
                        
                      manager.stopUpdatingLocation()

                    }
                }
                
            })
            
        }}

