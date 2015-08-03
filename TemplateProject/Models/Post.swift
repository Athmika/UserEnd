//
//  Post.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

// To create a custom Parse class you need to inherit from PFObject and implement the PFSubclassing protocol

class Post : PFObject, PFSubclassing {
    
    var image: UIImage?
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var address: String?
    @NSManaged var ward: String?
    @NSManaged var collectedDate: String?
    @NSManaged var isSegregated: Bool
    @NSManaged var isFeasible: Bool
    @NSManaged var textSent: Bool
    @NSManaged var isCompleted: Bool
    @NSManaged var array: [String]
    
    var photoUploadTask: UIBackgroundTaskIdentifier?

    //MARK: PFSubclassing Protocol
    
    // Creating a connection between the Parse class and the Swift class.

    static func parseClassName() -> String {
        return "Post"
    }
    
    func uploadPhoto() {
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        let imageFile = PFFile(data: imageData)
        
        

        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        

        imageFile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        // any uploaded post should be associated with the current user
        user = PFUser.currentUser()
        self.imageFile = imageFile
        saveInBackgroundWithBlock(nil)
    }
    
    // 4
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}