//
//  ProfileViewController.swift
//  Stackogram
//
//  Created by lighthouselabs on 2017-04-12.
//  Copyright © 2017 lighthouselabs. All rights reserved.
//
import Parse
import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    



    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "yourName"
        navigationItem.titleView = UIImageView(image: UIImage(named: "AppIcon"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {



        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
                        pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        
        self.present(pickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
                if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.current(){
                
           
                user["avatarImage"] = imageFile
                user.saveInBackground(block: { (success, error) -> Void in
                    if success {

                        let image = UIImage(data: imageData)
                        self.profileImageView.image = image
                    }
                })
                
            }
            
            
        }

        dismiss(animated: true, completion: nil)
        
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if let user = PFUser.current() {
            usernameLabel.text = user.username
            
            if let imageFile = user["avartarImage"] as? PFFile {
                
                imageFile.getDataInBackground(block: {(data, error) -> Void in
                    if let imageData = data {
                        self.profileImageView.image = UIImage(data: imageData)
                    
                    }
                })
        }
    }
}
}
