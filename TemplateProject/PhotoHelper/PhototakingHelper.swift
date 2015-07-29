//
//  PhototakingHelper.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//
import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper: NSObject  {
    
    /** View controller on which AlertViewController and UIImagePickerController are presented */
    
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var sender:UIButton
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, sender: UIButton, callback: PhotoTakingHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        self.sender = sender
        
        super.init()
        
        showAlert()
    }
    
    func showAlert()
    {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { (action) -> Void in  self.showImagePickerController(.PhotoLibrary)
        }
        
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            
            
            
            //Code for picking from camera roll goes here
        }
        actionSheetController.addAction(choosePictureAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as UIView;
        
        //Present the AlertController
        self.viewController.presentViewController(actionSheetController, animated: true, completion: nil)
        
        
    }
    
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType)
    {
        
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
