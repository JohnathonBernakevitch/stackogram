//
//  Post.swift
//  Stackogram
//
//  Created by lighthouselabs on 2017-04-19.
//  Copyright © 2017 lighthouselabs. All rights reserved.
//
import Parse
import Foundation
import UIKit
class Post: PFObject, PFSubclassing {
    @NSManaged var image:PFFile
    @NSManaged var user:PFUser
    @NSManaged var comment:String
    
    static func parseClassName() -> String {
        
        return "Post"
    }
    
    convenience init(image:PFFile, user:PFUser, comment:String)
    {
        self.init()
        self.image = image
        self.user = user
        self.comment = comment
    }
    
    var likes: PFRelation<PFObject>! {
        
        return relation(forKey: "likes")
    }
    
}
