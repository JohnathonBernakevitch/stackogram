//
//  Activity.swift
//  Stackogram
//
//  Created by lighthouselabs on 2017-05-10.
//  Copyright © 2017 lighthouselabs. All rights reserved.
//

import Foundation
import Parse
import UIKit

class Activity: PFObject, PFSubclassing {
    @NSManaged var type:String
    @NSManaged var user:PFUser
    @NSManaged var post:Post
    
    static func parseClassName() -> String {
        
        return "Activity"
    }
    
    convenience init(type:String, user:PFUser, post:Post)
    {
        self.init()
        self.type = type
        self.user = user
        self.post = post
    }
    
    
    
}
