//
//  FeedViewController.swift
//  Stackogram
//
//  Created by lighthouselabs on 2017-04-24.
//  Copyright © 2017 lighthouselabs. All rights reserved.
//
import Parse
import UIKit

class FeedViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var words = ["Hello","my","name","is","stackogram"]
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let query = Post.query() {
            
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            
            query.findObjectsInBackground(block: { (posts, error) -> Void in
                
                if let posts = posts as? [Post]{
                    self.posts = posts
                    self.tableView.reloadData()
                }
                
            })
        }


    }

    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
            let user = PFUser.current(){
                let post = Post(image: imageFile, user:user, comment: "A Selfie")
                
                post.saveInBackground(block: {(sucess, error) -> Void in
                    if sucess{
                        print("Post sucessfully saved in parse")
                        self.posts.insert(post, at: 0)
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                })
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
     
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! SelfieCell

        let post = self.posts[indexPath.row]
        
        cell.selfieImageView.image = nil
        
        cell.post = post
        
        return cell
    }

    
//    @IBAction func cameraButtonPressed(_ sender: Any) {

//        
//    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        if TARGET_OS_SIMULATOR == 1 {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        
        self.present(pickerController, animated: true, completion: nil)

    }
    
//    @IBAction func cameraButtonPressed(_ sender: Any) {
    
//
//        let pickerController = UIImagePickerController()
//
//       pickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//
//       if TARGET_OS_SIMULATOR == 1 {
//           pickerController.sourceType = .photoLibrary
//        } else {
//            pickerController.sourceType = .camera
//               pickerController.cameraDevice = .front
//             pickerController.cameraCaptureMode = .photo
//        }
//        
//    
//             self.present(pickerController, animated: true, completion: nil)
//
//    }
    
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
    
//            let me = User(aUsername: "sam", aProfileImage: UIImage(named: "Grumpy-Cat")!)
//            let post = Post(image: image, user: me, comment: "My Selfie")
    
//            posts.insert(post, at:0)
//        }
    
//      dismiss(animated: true, completion: nil)
    
//        tableView.reloadData()
//    }



        
        

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
