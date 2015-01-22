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
  
  //Make the class variable that represents an instance of the NetworkController. This lets allows us to use this one instance in all our classes so we don't have to keep transfering the NetworkController around to all our classes. We just call this class method then what every property or method we want.
  class var sharedNetworkController: NetworkController {
    struct Static{
      static let instance: NetworkController = NetworkController()
    }
    return Static.instance
  }
  
  
  let clientID = "600515052c69cb33ab6e"
  let mySecret = "b1d7f89597d6ac1a4c5a9597ac5a5f8f55bb6605"
  var URLSession: NSURLSession
  var accessTokenUserHTTPKey = "accessToken"
  var accessToken: String?
  let imageQueue = NSOperationQueue()
  
  
  init(){
    let configForFlashmemoryStore = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    self.URLSession = NSURLSession(configuration: configForFlashmemoryStore)
    if let accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessTokenUserHTTPKey) as? String {
      self.accessToken = accessToken
    }
  }
  
  func requestAccessToken(){
    let url = "https://github.com/login/oauth/authorize?client_id=\(self.clientID)&scope=user,repo"
    UIApplication.sharedApplication().openURL(NSURL(string: url)! )
  }
  
  
  func handleMainTokenRequest(passedURL: NSURL) {
    
    let accessCode = passedURL.query
    //println(accessCode)
    let stringForHTTPBody = "\(accessCode!)&client_id=\(self.clientID)&client_secret=\(self.mySecret)"
    println(stringForHTTPBody)
    let dataForHTTPBody = stringForHTTPBody.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    let lengthForHTTPBody = dataForHTTPBody?.length
    let postRequest = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token")!)
    postRequest.HTTPMethod = "POST"
    postRequest.setValue("\(lengthForHTTPBody)", forHTTPHeaderField: "Content-Length")
    postRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    postRequest.HTTPBody = dataForHTTPBody
    println(postRequest.HTTPBody)
    println(postRequest)
    
    let session = self.URLSession.dataTaskWithRequest(postRequest, completionHandler: { (returnedData, returnedResponse, returnedError) -> Void in
      if returnedError == nil{
        if let httpResponse = returnedResponse as? NSHTTPURLResponse{
          switch httpResponse.statusCode {
          case 200...299:
            var tokenRequestResponse = NSString(data: returnedData, encoding: NSASCIIStringEncoding) as NSString!
            self.accessToken = tokenRequestResponse.substringWithRange(NSRange(location: 13,length: 40))
            NSUserDefaults.standardUserDefaults().setObject(self.accessToken!, forKey: self.accessTokenUserHTTPKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
          default:
            break
          }
        }
      }
    })
    session.resume()
  }
  
  
  
  func getRepositoriesForSearchTerm(searchTerm: String, completion: ([RepositoryModel],NSError?) -> (Void)) {
    
    let URL = NSURL(string: "https://api.github.com/search/repositories?q=\(searchTerm)")
    let request = NSMutableURLRequest(URL: URL!)
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")
    
    let session = self.URLSession.dataTaskWithRequest(request, completionHandler: { (returnedData, responseCode, errorMessage) -> Void in
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
            println(httpResponse.statusCode)
          }
        }
      }
    })
    session.resume()
  }
  
  func getUserForSearchTerm(searchTerm: String, completion: ([UserModel],NSError?) ->Void){
    let URL = NSURL(string: "https://api.github.com/search/users?q=\(searchTerm)")
    let request = NSMutableURLRequest(URL: URL!)
    request.setValue("token \(self.accessToken!)", forHTTPHeaderField: "Authorization")
    
    let session = self.URLSession.dataTaskWithRequest(request, completionHandler: { (returnedData, responseCode, returnedError) -> Void in
      if returnedError == nil {
        if let httpResponse = responseCode as? NSHTTPURLResponse{
          var arrayOfUserObjects = [UserModel]()
          switch httpResponse.statusCode{
          case 200...299:
            if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(returnedData, options: nil, error: nil) as? [String:AnyObject]{
              
              let arrayOfUsers = jsonDictionary["items"] as [[String:AnyObject]]
              for U in arrayOfUsers{
                let user = UserModel(jsonString: U)
                arrayOfUserObjects.append(user)
              }
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(arrayOfUserObjects, returnedError)
              })
            }
          default:
            println(httpResponse.statusCode)
          }
        }
      }
    })
    session.resume()
  }
  
  
  func downloadUserImage(user: UserModel, completion: (UIImage) -> Void) {
    
    imageQueue.addOperationWithBlock { () -> Void in
      
      let imageData = NSData(contentsOfURL: user.imageURL!)
      let image = UIImage(data: imageData!)//as UIImage
      NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        
        completion(image!)
        
      }
    }
  }
  
  
  
//End Class
}