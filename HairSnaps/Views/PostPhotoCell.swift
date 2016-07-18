//
//  PostPhotoCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PostPhotoCell Class;
class PostPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    var photo: String! {
        didSet {
            // Photo;
            let url = NSURL(string: photo)
            photoView.sd_setImageWithURL(url, placeholderImage: nil)
        }
    }
}
