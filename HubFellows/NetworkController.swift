//
//  NetworkController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/19/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class NetworkController{
  
  
  var URLSession: NSURLSession
  
  
  init(){
    let configForFlashmemoryStore = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    self.URLSession = NSURLSession(configuration: configForFlashmemoryStore)
  }
  
  func getRepositoriesForSearchTerm(searchTerm: String, completion: ([RepositoryModel],NSError?) -> (Void)) {
    
    let URL = NSURL(string: "http://127.0.0.1:3000")
    let session = self.URLSession.dataTaskWithURL(URL!, completionHandler: { (returnedData, responseCode, errorMessage) -> Void in
      if errorMessage == nil {
        if let httpResponse = responseCode as? NSHTTPURLResponse{
          var finalArrayOfRepos = [RepositoryModel]()
          
          
          switch httpResponse.statusCode{
          case 200...299:
            if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(returnedData, options: nil, error: nil) as? [String:AnyObject]{
              let arrayOfRepos = jsonDictionary["items"] as? [[String:AnyObject]]
              for R in arrayOfRepos!{
                let repo = RepositoryModel(jsonString: R )
                finalArrayOfRepos.append(repo)
              }
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(finalArrayOfRepos, errorMessage )
              })
            }
            
            
          default:
            break
          }
        }
        //let arrayOfRepos = dictionaryForRepoData["items"] as [AnyObject]
       
  
        
      }
    })
    session.resume()
    
    
    
  }
  
//End Class
}