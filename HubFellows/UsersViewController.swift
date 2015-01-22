//
//  UsersViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var myCollectionView: UICollectionView!
  
  @IBOutlet weak var mySearchBar: UISearchBar!
  
  var arrayOfUsers = [UserModel]()
  
  var btnRefresh: UIBarButtonItem?
  var actionIndicator: UIActivityIndicatorView?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    btnRefresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refresh")
    actionIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    actionIndicator?.color = UIColor.greenColor()
    actionIndicator?.hidesWhenStopped = true
    actionIndicator?.frame = CGRectMake(0, 0, 50, 50)
    self.view.addSubview(actionIndicator!)
    self.myCollectionView.backgroundColor = UIColor.whiteColor()
    self.mySearchBar.delegate = self
    self.navigationController?.delegate = self
    //self.myCollectionView.
  }
  
  
  
  //MARK: CollectionView Shit
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.arrayOfUsers.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("userCell", forIndexPath: indexPath) as UserCellModel
    Cell.myUserImageView.image = nil
    if self.arrayOfUsers[indexPath.row].avatarImage == nil{
      NetworkController.sharedNetworkController.downloadUserImage(self.arrayOfUsers[indexPath.row], completion: { (returnedImage) -> Void in
        
        self.arrayOfUsers[indexPath.row].avatarImage = returnedImage
        Cell.myUserImageView.image = returnedImage
      })
    }else{
      Cell.myUserImageView.image = self.arrayOfUsers[indexPath.row].avatarImage
    }
    
    Cell.myUserLabel.text = self.arrayOfUsers[indexPath.row].userName
    return Cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("showUserDetail", sender: self)
  }
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let DVC = segue.destinationViewController as UserDetailViewController
    let IP = self.myCollectionView.indexPathsForSelectedItems().first as NSIndexPath
    DVC.userModel = self.arrayOfUsers[IP.row]
  }
  
  
  func refresh() {
    let text = mySearchBar.text.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
    NetworkController.sharedNetworkController.getUserForSearchTerm(text, completion: { (returnedArrayOfUsers, error) -> Void in
      self.actionIndicator?.startAnimating()
      self.arrayOfUsers = returnedArrayOfUsers
      self.myCollectionView.reloadData()
      self.actionIndicator?.stopAnimating()
    })

  }
  
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    let text = searchBar.text.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
    
    NetworkController.sharedNetworkController.getUserForSearchTerm(text, completion: { (returnedArrayOfUsers, error) -> Void in
      self.actionIndicator?.startAnimating()
      self.navigationItem.rightBarButtonItem = self.btnRefresh
      self.myCollectionView.dataSource = self
      self.myCollectionView.delegate = self
      self.myCollectionView.registerNib(UINib(nibName: "UserCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "userCell")
      let myFlowLayout = self.myCollectionView.collectionViewLayout as UICollectionViewFlowLayout
      myFlowLayout.itemSize = CGSize(width: 130, height:162 )// = UICollectionViewAutomaticDimensions
      myFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
      self.arrayOfUsers = returnedArrayOfUsers
      self.myCollectionView.reloadData()
      self.actionIndicator?.stopAnimating()
    })
    mySearchBar.resignFirstResponder()
    
    
  }
  
  
  
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if fromVC is UsersViewController && toVC is UserDetailViewController{
      return ToUserDetailAnimationController()
    }else{
      return nil
    }
  }
  
  
}
