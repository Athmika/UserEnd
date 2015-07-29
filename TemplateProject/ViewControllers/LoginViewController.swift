//
//  FirstViewController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
var phone: String = ""

class LoginViewController: UIViewController {

    
    @IBOutlet weak var phoneNumberField: UITextField!
    let userAlertQuery = UserAlert.query()
    //let postLocal = PostLocal()
    var userPosts: [UserAlert] = []
    var newUser: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            userAlertQuery!.whereKey("phone", equalTo: phoneNumberField.text)
            //println(phoneNumberField.text)
            phone = phoneNumberField.text
            userAlertQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
                self.userPosts = result as? [UserAlert] ?? []
                
                if self.userPosts.count != 0
                {
                   //println("hi")
                }
                else
                {
                    self.newUser = true
                
                }
                
                println(self.userPosts)
               self.next()
            }
         
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
}
