//
//  RepositoriesViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/19/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  
  @IBOutlet weak var myTableView: UITableView!
  
  
  var NC = NetworkController()
  var arrayOfRepositories: [RepositoryModel]?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NC.getRepositoriesForSearchTerm("Swift", completion: { (arrayOfRepos, error) -> Void in
      self.arrayOfRepositories = arrayOfRepos
      for r in self.arrayOfRepositories!{
        println(r.repoName)
      }
      self.myTableView.dataSource = self
      self.myTableView.delegate = self
      self.myTableView.reloadData()
      
      
    })
    
    
    
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrayOfRepositories!.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let Cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as UITableViewCell
    
    
      let repo = arrayOfRepositories![indexPath.row] as RepositoryModel
      Cell.textLabel?.text = repo.repoName
      Cell.detailTextLabel?.text = repo.repoURL.absoluteString
    
    
    return Cell
    
    
  }
  
  
}