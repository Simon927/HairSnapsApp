//
//  ActivityCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ActivityCell Class;
class ActivityCell: UITableViewCell {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    weak var activity: Activity! {
        didSet {
            // Photo;
            photoButton.sd_setImageWithURL(NSURL(string: activity.user.photo), forState: UIControlState.Normal, placeholderImage: UIImage(named: "profile_placholder"))
            
            // Description;
            descriptionLabel.text = activity.message
            
            // Time;
            timeLabel.text = Time.timeAgo(activity.created_at)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // User;
        photoButton.layer.borderWidth = 2
        photoButton.layer.borderColor = UIColor.whiteColor().CGColor
        photoButton.layer.cornerRadius = 16
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
