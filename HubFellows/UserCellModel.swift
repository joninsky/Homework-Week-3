//
//  UserCellModel.swift
//  HubFellows
//
//  Created by Jon Vogel on 1/20/15.
//  Copyright (c) 2015 Jon Vogel. All rights reserved.
//

import UIKit

class UserCellModel: UICollectionViewCell {
  
  @IBOutlet weak var myUserImageView: UIImageView!
  
  @IBOutlet weak var myUserLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
//  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes! {
//    let arrayOfAttributes = layoutAttributes
//    
//    let size = self.myUserLabel.sizeThatFits(CGSizeMake(CGRectGetWidth(layoutAttributes.frame), CGFloat.max))
//    let newFrame = arrayOfAttributes.frame //as CGRect
//    newFrame.size.height = size.height
//    arrayOfAttributes.frame = newFrame
//    
//    return arrayOfAttributes
//  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.myUserLabel.preferredMaxLayoutWidth = self.myUserLabel.frame.width
  }

}
