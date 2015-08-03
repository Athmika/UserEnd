//
//  FirstViewController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

import Foundation
import SystemConfiguration

import ReachabilitySwift


var phone: String = ""

class LoginViewController: UIViewController {
 
    
    @IBOutlet weak var phoneNumberField: UITextField!
    let userAlertQuery = UserAlert.query()
    
    @IBOutlet weak var nextButton: UIButton!
    var userPosts: [UserAlert] = []
    var newUser: Bool = false
    var query: PFQuery?
    let reachability = Reachability.reachabilityForInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func next()
    {
        if (newUser == true)
        {
            performSegueWithIdentifier("goForward", sender: self)
        }
        else
        {
            performSegueWithIdentifier("goForwardOldUser", sender: self)
        }
    }
    

    @IBAction func proceedButton(sender: UIButton) {
        newUser = false
        
        if (phoneNumberField.text == "")
        {
            var alert = UIAlertController(title: "Alert", message: "The password is incorrect", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            query = userAlertQuery!.whereKey("phone", equalTo: phoneNumberField.text)
         
            phone = phoneNumberField.text
            
            self.query(query!)
            
        
        }
        
    
   
    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "goForwardOldUser")
        {
            
            var good: StatusViewController = segue.destinationViewController as! StatusViewController
            
            good.alertPost = userPosts[0]
    
good.isFeasible = userPosts[0].isFeasible
good.isCompleted = userPosts[0].isCompleted
        good.textSent = userPosts[0].textSent
        good.delete = userPosts[0].deleted
       
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    @IBAction func unwindToLoginViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindToLoginViewController2(segue: UIStoryboardSegue) {
    }
    

    
    func query(query: PFQuery)
    {
        self.nextButton.enabled = false
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            if let error = error
            {
            ErrorHandling.defaultErrorHandler(error)
            }
            self.userPosts = result as? [UserAlert] ?? []
            if self.userPosts.count == 0
            {
             self.newUser = true
            }
            println(self.userPosts)
            self.nextButton.enabled = true
            self.next()
        }
    }
    
    func alert(alertMsg: String)
    {
        var alert = UIAlertController(title: "Alert", message: alertMsg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
