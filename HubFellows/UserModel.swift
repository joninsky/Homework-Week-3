//
//  UserModelSwift.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit



struct UserModel {
  
  var json: [String:AnyObject]
  var userName: String
  var imageURL: NSURL?
  var avatarImage: UIImage?
  var score: Float
  var repoURL: NSURL
  
  
  init(jsonString: [String:AnyObject]){

    self.json = jsonString as [String:AnyObject]
   // println(self.json)
    self.userName = json["login"] as String
    self.imageURL = NSURL(string: json["avatar_url"] as String)!
    self.score = json["score"] as Float
    self.repoURL = NSURL(string: json["repos_url"] as String)!
  }
  

  
}