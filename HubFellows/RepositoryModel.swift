//
//  RepositoryModel.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/19/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation

struct RepositoryModel {
  
  var json: [String:AnyObject]
  var repoName: String
  var repoURL: NSURL
  
  
  init(jsonString: [String:AnyObject]){
    self.json = jsonString as [String:AnyObject]
    //println(self.json)
    self.repoName = json["name"] as String
    self.repoURL = NSURL(string: json["html_url"] as String)!
    
    println(self.repoName)
  }
  
  
}