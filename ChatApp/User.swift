//
//  User.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/20/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

class User : PFUser  {


    @NSManaged var profileImage: PFFile
    @NSManaged var name : String
    @NSManaged var profileName : String





    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
}
