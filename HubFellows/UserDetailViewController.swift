//
//  UserDetailViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/21/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  
  var userModel: UserModel?
  
  @IBOutlet weak var myImageView: UIImageView!
  
  @IBOutlet weak var lblScore: UILabel!
  
  @IBOutlet weak var lblReposURL: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.myImageView.image = userModel!.avatarImage
    self.lblScore.text = "\(userModel!.score!)"
    self.lblReposURL.text = userModel!.repoURL!.absoluteString
    
    
    
  }
  
  
  
}
