//
//  ToUserDetailAnimationController.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/21/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject, UIViewControllerAnimatedTransitioning{
  
  
  //Required funciton that you define the total animation time in
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 1.0
  }
  
  
  //Required funciton that defines all of the actual animation.
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    //Get a reference to the two view controllers that the animation is going to take place between
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UsersViewController
    let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserDetailViewController
   
    let containerView = transitionContext.containerView()
    
    //Now, get a snap shot of the selected Cell. We will animate the snap shot. The actual image transfer will just take place in the segue.
    let selectedIndexPath = fromVC.myCollectionView.indexPathsForSelectedItems().first as NSIndexPath
    let Cell = fromVC.myCollectionView.cellForItemAtIndexPath(selectedIndexPath) as UserCellModel
    let snapShotOfCell = Cell.myUserImageView.snapshotViewAfterScreenUpdates(false)
    //We have to hide the cell that we took a snap shot from. Otherwise the user wil think we took a snap shot rather than transtitioning the cell even though we are actually taking a snap shot of the cell. We don't want the user to know our tricks.
    Cell.myUserImageView.hidden = true
    snapShotOfCell.frame = containerView.convertRect(Cell.myUserImageView.frame, fromView: Cell.myUserImageView.superview)
    
    toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
    toVC.view.alpha = 0
    toVC.myImageView.hidden = true
    
    containerView.addSubview(toVC.view)
    containerView.addSubview(snapShotOfCell)
    
    toVC.view.setNeedsLayout()
    toVC.view.layoutIfNeeded()
    
    let duration = transitionDuration(transitionContext)
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      toVC.view.alpha = 1.0
      let frame = containerView.convertRect(toVC.myImageView.frame, fromView: toVC.view)
      snapShotOfCell.frame = frame
      
    }) { (finished) -> Void in
      toVC.myImageView.hidden = false
      Cell.myUserImageView.hidden = false
      snapShotOfCell.removeFromSuperview()
      transitionContext.completeTransition(true)
    }
    
    
    
  }
  
  
}
