//
//  GroupCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import AssetsLibrary

// --- Defines ---;
// GroupCell Class;
class GroupCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    weak var group: ALAssetsGroup! {
        didSet {
            // Thumbnail;
            group.enumerateAssetsUsingBlock({ (asset: ALAsset!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if (asset != nil){
                    // Image;
                    self.thumbnailView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
                    
                    // Stop;
                    stop.initialize(true)
                }
            })
            
            // Title;
            let title = group.valueForProperty(ALAssetsGroupPropertyName) as String
            titleLabel.text = title
            
            // Count;
            countLabel.text = String(group.numberOfAssets())
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
