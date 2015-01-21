//
//  UsersViewController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet weak var myCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.myCollectionView.dataSource = self
    self.myCollectionView.delegate = self
    self.myCollectionView.registerNib(UINib(nibName: "UserCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "userCell")
    self.myCollectionView.backgroundColor = UIColor.whiteColor()
    let myFlowLayout = myCollectionView.collectionViewLayout as UICollectionViewFlowLayout
    myFlowLayout.itemSize = CGSize(width: 100, height: 150)// = UICollectionViewAutomaticDimensions
    //self.myCollectionView.
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1000
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("userCell", forIndexPath: indexPath) as UserCellModel
    Cell.myUserImageView.backgroundColor = UIColor.redColor()
    Cell.myUserLabel.backgroundColor = UIColor.grayColor()
    return Cell
  }
  
  
}
