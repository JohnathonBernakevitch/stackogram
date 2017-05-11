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
        
        let imageFile = post.image
        imageFile.getDataInBackground(block: {(data, error) -> Void in
            if let data = data {
                let image = UIImage(data: data)
                self.selfieImageView.image = image
            }
        })
        
        usernameLabel.text = post.user.username

        commentLabel.text = post.comment

        
    }
    }
}




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
                    }else{
                        print("error is \(error)")
                    }
                })
   
            } else {
                                        post.likes.remove(user)
                        post.saveInBackground(block: { (success, error) -> Void in
                            if success {
                                print("like from user successfully removed")
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
