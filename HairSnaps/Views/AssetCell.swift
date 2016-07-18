//
//  AssetCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import AssetsLibrary

// --- Defines ---;
// AssetCell Class;
class AssetCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    weak var asset: ALAsset! {
        didSet {
            photoView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
        }
    }
    
    var badge: Int! {
        didSet {
            // Badge;
            badgeView.hidden = badge == NSNotFound
            
            // Badge Label;
            if (badge != NSNotFound) {
                badgeLabel.text = String(badge + 1)
            }
        }
    }
}
