//
//  ImageCell.swift
//  FAPaginationLayout
//
//  Created by Fahid Attique on 14/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
  
    //  IBOutlets
    
    @IBOutlet var wallpaperImageView: UIImageView!

    
    //  Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProduct.layer.masksToBounds = true
        //contentView.layer.borderColor = UIColor.gray.cgColor
       // cell.contentView.layer.borderWidth = 1.0
        
     //   self.lblTitle.font = MySingleton.sharedManager().themeFontSixteenSizeBold
      //  self.lblTitle.textColor = MySingleton.sharedManager().themeGlobalDarkGreyColor
        
      //  self.lblDescription.font = MySingleton.sharedManager().themeFontSixteenSizeMedium
      //  self.lblDescription.textColor = MySingleton.sharedManager().themeGlobalDarkGreyColor
        
        mainContainerView.layer.cornerRadius = 10
        mainContainerView.layer.shadowColor = MySingleton.sharedManager().themeGlobalGreyColor?.cgColor
        mainContainerView.layer.shadowOpacity = 0.7
        mainContainerView.layer.shadowOffset = CGSize.zero
        mainContainerView.layer.shadowRadius = 4
        
       // self.btnSelect.layer.borderColor = MySingleton.sharedManager().themeGlobalBlueColor?.cgColor
        self.btnSelect.layer.borderWidth = 1
        
        self.btnSelect.layer.cornerRadius = self.btnSelect.frame.height / 2
       // self.btnSelect.layer.masksToBounds = true
        
        // Initialization code
    }

}
