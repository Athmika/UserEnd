//
//  SegregatedWasteController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit

class SegregatedWasteController: UIViewController, CheckboxDelegate {
    
    let mCheckboxTitles = ["Paper", "Cartons", "Plastic", "Plastic films","Multilayer Laminates", "Cocunt shells", "Glass Bottle"];
    var checkboxState = [String:Bool]()
    var selectedCheckboxes = [String]()
    var isSegregated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCheckboxes();
        isSegregated = false
    }
    
    override func didReceiveMemoryWarning() {
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
    func didSelectCheckbox(state: Bool, identifier: Int, title: String) {
        checkboxState[title] = state
    }

    
  @IBAction func NextButton(sender: UIButton)
    {
       isSegregated = true
        
        /* for (title, state) in checkboxState {
            println("The state of \(title) is \(state)")} */
        
    }

   
}