//
//  WebViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  
  

  
  var urlToGoTo: NSURL?
  let webView = WKWebView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let rootView = self.view
    
    self.webView.frame = self.view.frame
    self.webView.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.view.addSubview(self.webView)
    
    let dictionaryOfViews = ["webView": webView]
    webView.loadRequest(NSURLRequest(URL: urlToGoTo!))
    addConstraints(rootView, dicOfViews: dictionaryOfViews)
    
    
  }
  
  
  func addConstraints(theView: UIView, dicOfViews: [String:UIView]){
    
    let webViewVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|", options: nil, metrics: nil, views: dicOfViews)
    let webViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: nil, metrics: nil, views: dicOfViews)
    
    theView.addConstraints(webViewVerticalConstraint)
    theView.addConstraints(webViewHorizontalConstraint)
    
    
    
  }
  
  
  
}
