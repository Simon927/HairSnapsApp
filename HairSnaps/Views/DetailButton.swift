//
//  DetailButton.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// DetailButton Class;
class DetailButton: UIButton {
    
    var additionalTitleLabel: UILabel! = nil;
    var additionalSubtitleLabel: UILabel! = nil;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Remove Title;
        titleLabel?.removeFromSuperview()
    }
    
    override func contentRectForBounds(bounds: CGRect) -> CGRect {
        // Title and Subtitle;
        additionalTitleLabel.textColor = titleColorForState(state)
        additionalSubtitleLabel.textColor = titleColorForState(state)
        
        return bounds
    }
    
    func setTitle(title: String?, andSubtitle subtitle: String?) {
        // Additional Title;
        if (additionalTitleLabel == nil) {
            additionalTitleLabel = UILabel(frame: CGRectMake(0, 33, self.frame.size.width, 11))
            additionalTitleLabel.tag = 1516
            additionalTitleLabel.backgroundColor = UIColor.clearColor()
            additionalTitleLabel.font = UIFont(name: "AvenirNext-Medium", size: 8.0)
            additionalTitleLabel.textAlignment = NSTextAlignment.Center
            additionalTitleLabel.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleRightMargin
            
            addSubview(additionalTitleLabel)
        }
        
        additionalTitleLabel.text = title

        // Additional Subtitle;
        if (additionalSubtitleLabel == nil) {
            additionalSubtitleLabel = UILabel(frame: CGRectMake(0, 8, self.frame.size.width, 25))
            additionalSubtitleLabel.tag = 1516
            additionalSubtitleLabel.backgroundColor = UIColor.clearColor()
            additionalSubtitleLabel.font = UIFont(name: "AvenirNext-Medium", size: 20.0)
            additionalSubtitleLabel.textAlignment = NSTextAlignment.Center
            additionalSubtitleLabel.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleRightMargin
            
            addSubview(additionalSubtitleLabel)
        }
        
        additionalSubtitleLabel.text = subtitle
    }
}
