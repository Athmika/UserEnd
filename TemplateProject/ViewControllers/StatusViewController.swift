//
//  StatusViewController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var label: UITextView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var alertPost:UserAlert!
    var isFeasible:Bool!
    var isCompleted:Bool!
    var textSent:Bool!
    var delete:Bool!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    if(!textSent)
    {
    
        label.text = "Your request has been recieved. You'll be notified on further updates"
    }
    
    else
        {
        if (isCompleted == true)
            {
                label.text = "Your request has been marked completed"
                confirmButton.setTitle("Click to confirm", forState: .Normal)
                
        }
        
        else if (!isFeasible)
        {
        label.text = "Your request is not feasible"
       confirmButton.setTitle("Ok", forState: .Normal)
        }
            
        else if(isFeasible == true)
        {
            label.text = "Your request is feasible"
        confirmButton.setTitle("Ok", forState: .Normal)
        }
        
         else if (delete == true)
        {
           label.text = "Your request has been cancelled, as the collection is not feasible"
            confirmButton.setTitle("Ok", forState: .Normal)
        }
            
        }
        
    }
    
    @IBAction func finalButton(sender: UIButton)
    {
       if (isCompleted == true)
       {
        deleteUserAlert()
        }
        else if (!isFeasible)
        {
         deleteUserAlert()
        }
    performSegueWithIdentifier("gotoLoginViewController2", sender: self)
        
    }
    
    func deleteUserAlert()
    {
      alertPost.deleteInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
