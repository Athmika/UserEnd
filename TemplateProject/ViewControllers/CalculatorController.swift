//
//  CalculatorController.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/25/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {

    var total = 0.0
    
 
    @IBOutlet weak var peperLabel: UILabel!
    @IBOutlet weak var CartonsLabel: UILabel!
  
    @IBOutlet weak var plasticFilmLabel: UILabel!
    @IBOutlet weak var PlasticLabel: UILabel!
    
    @IBOutlet weak var multifilmLabel: UILabel!
    
    @IBOutlet weak var coconutLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueLabel1: UILabel!
    @IBOutlet weak var valueLabel2: UILabel!
    @IBOutlet weak var valueLabel3: UILabel!
    @IBOutlet weak var valueLabel4: UILabel!
    @IBOutlet weak var valueLabel5: UILabel!
    @IBOutlet weak var valueLabel6: UILabel!
    @IBOutlet weak var valueLabel7: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peperLabel.text  = "Paper"
        CartonsLabel.text = "Cartons"
        PlasticLabel.text = "Plastic"
        plasticFilmLabel.text = "Plastic films"
        multifilmLabel.text = "Multilayer Laminates"
        coconutLabel.text = "Coconut shells"
        glassLabel.text = "Glass Bottle"
    }
    
    var sender0 = 0.0
    var sender1 = 0.0
    var sender2 = 0.0
    var sender3 = 0.0
    var sender4 = 0.0
    var sender5 = 0.0
    var sender6 = 0.0
    var sender7 = 0.0
    
    
    @IBAction func stepper(sender: UIStepper)
    {
        
        valueLabel.text = "\(sender.value)"
        sender0 = sender.value
        calculateTotal()
        
    }
    
    @IBAction func stepper1(sender: UIStepper)
    {
        
        valueLabel1.text = "\(sender.value)"
        sender1 = sender.value
        calculateTotal()
    }
    
    
    @IBAction func stepper2(sender: UIStepper)
    {
        valueLabel2.text = "\(sender.value)"
        sender2 = sender.value
        calculateTotal()
    }
    
    @IBAction func stepper3(sender: UIStepper)
    {
        valueLabel3.text = "\(sender.value)"
        sender3 = sender.value
        calculateTotal()
        
    }
    
    
    @IBAction func stepper4(sender: UIStepper)
    {
        valueLabel4.text = "\(sender.value)"
        sender4 = sender.value
        calculateTotal()
    }
    
    @IBAction func stepper5(sender: UIStepper)
    {
        valueLabel5.text = "\(sender.value)"
        sender5 = sender.value
        calculateTotal()
    }
    
    @IBAction func stepper6(sender: UIStepper)
    {
        valueLabel6.text = "\(sender.value)"
        sender6 = sender.value
        calculateTotal()
        
    }
    
    
    @IBAction func stepper7(sender: UIStepper)
    {
        valueLabel7.text = "\(sender.value)"
        sender7 = sender.value
        calculateTotal()
        
    }
    
    func calculateTotal()
    {
        total = sender0 + sender1 + sender2 + sender3 + sender4 + sender5 + sender6 + sender7
        totalLabel.text = "\(total)"
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

