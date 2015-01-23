//
//  ViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/19/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Options"
  
  
  
  
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.delegate = nil
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if NetworkController.sharedNetworkController.accessToken == nil {
      NetworkController.sharedNetworkController.requestAccessToken()
    }
    
    
  }

  

}

