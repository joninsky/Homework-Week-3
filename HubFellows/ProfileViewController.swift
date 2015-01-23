//
//  ProfileViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/22/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  
  @IBOutlet weak var myImageView: UIImageView!
  
  @IBOutlet weak var lblFollowers: UILabel!
  
  @IBOutlet weak var lblFollowing: UILabel!
  
  var theUser: UserModel?
  
  var newRepoText: String?
  
  var alertController = UIAlertController(title: "AddRepo", message: "Would you like to create a new repository?", preferredStyle: UIAlertControllerStyle.Alert)
  var alertControllerWithName = UIAlertController(title: "Choose a Name", message: "Please choose a name for your new repo", preferredStyle: UIAlertControllerStyle.Alert)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NetworkController.sharedNetworkController.getSignedInUser { (theUser, error) -> Void in
      self.theUser = theUser
      self.lblFollowers.text = self.lblFollowers.text! + " \(theUser.followers!)"
      self.lblFollowing.text = self.lblFollowing.text! + " \(theUser.following!)"
      self.navigationItem.title = "\(theUser.userName)"
      self.refreshControls()
    }
    
    let alertActionYes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (action) -> Void in
      
      self.alertControllerWithName.addTextFieldWithConfigurationHandler({ (textField) -> Void in
        
      })
      self.presentViewController(self.alertControllerWithName, animated: true, completion: nil)
    }
    
    let alertActionCancell = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (action) -> Void in
      
      
    }
    let alertActionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
      
      let textField = self.alertControllerWithName.textFields?.first as UITextField
      self.newRepoText = "\(textField.text)"
      println(self.newRepoText!)
      NetworkController.sharedNetworkController.postNewRepo(self.newRepoText!, completion: { (error) -> Void in
        
        
        
        
      })
      
    }
   
    
    
    self.alertController.addAction(alertActionYes)
    self.alertController.addAction(alertActionCancell)
    self.alertControllerWithName.addAction(alertActionOK)
    //self.alertController.actions[0].hidden = true
    
  }
  
  
  
  func refreshControls() {
    NetworkController.sharedNetworkController.downloadUserImage(theUser!, completion: { (theImage) -> Void in
      self.theUser!.avatarImage = theImage
      self.myImageView.image = theImage
      
    })
  }
  
  
  @IBAction func addRepo(sender: AnyObject) {
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  
  
  
}
