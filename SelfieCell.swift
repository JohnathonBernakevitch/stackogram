//
//  SelfieCell.swift
//  Stackogram
//
//  Created by lighthouselabs on 2017-04-26.
//  Copyright © 2017 lighthouselabs. All rights reserved.
//

import UIKit
import Parse
class SelfieCell: UITableViewCell {
    
    @IBOutlet weak var selfieImageView: UIImageView!
    
    var post:Post?{
        
        didSet{
        
        if let post = post {
            
            selfieImageView.image = nil
        
        let imageFile = post.image
        imageFile.getDataInBackground(block: {(data, error) -> Void in
            if let data = data {
                let image = UIImage(data: data)
                self.selfieImageView.image = image
            }
        })
        
        usernameLabel.text = post.user.username

        commentLabel.text = post.comment
            
        likeButton.isSelected = false

        let query = post.likes.query()
            query.findObjectsInBackground(block: {(users, error) -> Void in
                
                if let users = users as? [PFUser]{
                    for user in users {
                        if user.objectId == PFUser.current()?.objectId{
                            self.likeButton.isSelected = true
                        }
                    }
                }
            })
            }
        }
    }


    @IBOutlet weak var likeButton: UIButton!



    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        
        if let post = post,
            let user = PFUser.current(){
            
            if sender.isSelected {
                post.likes.add(user)
                
                post.saveInBackground(block: { (success, error) -> Void in
                    if success{
                        print("like from user successfully saved")
                        
                        let activity = Activity(type: "like", user: user, post: post)
                        activity.saveInBackground(block: {(success, error) -> Void in
                            print("activity sucessfully saved")
                        })
                        
                    }else{
                        print("error is \(error)")
                    }
                })
   
            } else {
                        post.likes.remove(user)
                        post.saveInBackground(block: { (success, error) -> Void in
                            if success {
                                print("like from user successfully removed")
                                
                                if let activityQuery = Activity.query(){
                                    
                                    activityQuery.whereKey("post", equalTo: post)
                                    activityQuery.whereKey("user", equalTo: user)
                                    activityQuery.whereKey("type", equalTo: "like")
                                    activityQuery.findObjectsInBackground(block: {(activities, error) -> Void in
                                        
                                        if let activities = activities {
                                            for activity in activities{
                                                activity.deleteInBackground(block:{(sucess, error) -> Void in
                                                    print("deleted activity")
                                                })
                                            }
                                        }
                                    })
                                    
                                    
                                }
                                
                                
                            }else{
                                print("error is \(error)")
                            }
                })
            }

        }
    }
    
    
                                
                                
                                

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
