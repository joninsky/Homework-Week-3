//
//  WebViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
  
  
  
  
  
  @IBOutlet weak var myWebView: UIWebView!
  
  var urlToGoTo: NSURL?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    myWebView.loadRequest(NSURLRequest(URL: urlToGoTo!))
    
    
    
  }
  
  
  
}
