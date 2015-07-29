//
//  SegregatedWasteController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit

class SegregatedWasteController: UIViewController, CheckboxDelegate
{
    
    let mCheckboxTitles = ["Paper", "Cartons", "Plastic", "Plastic films","Multilayer Laminates", "Coconut shells", "Glass Bottle"]
    var checkboxState = [String:Bool]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.createCheckboxes()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func createCheckboxes() {
        
        let lNumberOfCheckboxes = 7;
        let lCheckboxHeight: CGFloat = 44.0;
        
        var lFrame = CGRectMake(100, 80, self.view.frame.size.width, lCheckboxHeight);
        
        for (var counter = 0; counter < lNumberOfCheckboxes; counter++) {
            var lCheckbox = Checkbox(frame: lFrame, title: mCheckboxTitles[counter], selected: false);
            lCheckbox.mDelegate = self;
            lCheckbox.tag = counter;
            
            self.view.addSubview(lCheckbox);
            
            lFrame.origin.y += lFrame.size.height;
        }
    }
    
   
   //Saves the state in a dictionary
    func didSelectCheckbox(state: Bool, identifier: Int, title: String)
    {
         checkboxState[title] = state
        
    }
    
    @IBAction func nextButton(sender: UIButton)
    {
    //prepareForSegu(segue: , sender: sender)
    
    }
    
    
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
        {
            var count = 0
            for (item,state) in checkboxState
            {
                if state == true
                {
                    count = 1
                }
            }
            
            if (count == 1)
            {
                var dictionary1: RequestEntryViewController = segue.destinationViewController as! RequestEntryViewController
                
                dictionary1.dictionary = checkboxState
            }
                
            else
            {
                var alert = UIAlertController(title: "Alert", message: "Check at least one box", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }

        
    }
    
}



   