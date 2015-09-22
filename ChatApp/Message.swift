//
//  Message.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/22/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

class Message : PFObject  {


    @NSManaged var sender: String
    @NSManaged var other : String
    @NSManaged var message : String





    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
}