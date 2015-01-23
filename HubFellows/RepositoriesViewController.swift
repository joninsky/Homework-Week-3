//
//  RepositoriesViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/19/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
  
  @IBOutlet weak var myTableView: UITableView!
  
  @IBOutlet weak var mySearchBar: UISearchBar!
  
  @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
  
  
  
  var NC = NetworkController()
  var arrayOfRepositories: [RepositoryModel]?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.mySearchBar.delegate = self
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let IP = self.myTableView.indexPathForSelectedRow() as NSIndexPath!
    let repo = self.arrayOfRepositories![IP.row] as RepositoryModel
    let DVC = segue.destinationViewController as WebViewController
    DVC.urlToGoTo = repo.repoURL
  }
  
  //MARK: Table View Shit
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrayOfRepositories!.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let Cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as UITableViewCell
    let repo = self.arrayOfRepositories![indexPath.row] as RepositoryModel
    Cell.textLabel?.text = repo.repoName
    Cell.detailTextLabel?.text = repo.repoURL.absoluteString
    return Cell
    
    
  }
  
 
  
  
  //MARK: Search Bar delegate method
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    //self.myActivityIndicator.startAnimating()
    let text = searchBar.text.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
    println(text)
    NetworkController.sharedNetworkController.getRepositoriesForSearchTerm(text, completion: { (arrayOfRepos, error) -> (Void) in
      self.arrayOfRepositories = arrayOfRepos
      self.myTableView.dataSource = self
      self.myTableView.delegate = self
      //self.myActivityIndicator.stopAnimating()
      self.myTableView.reloadData()
    })
    
    searchBar.resignFirstResponder()
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validateSearchString()
  }
  
  
}