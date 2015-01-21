//
//  UserModelSwift.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation



struct UserModel {
  
  var json: [String:AnyObject]
  var userName: String
  var imageURL: NSURL
  
  
  init(jsonString: [String:AnyObject]){
    self.json = jsonString as [String:AnyObject]
    self.userName = json["name"] as String
    self.imageURL = NSURL(string: json["html_url"] as String)!
  }
  
  
}