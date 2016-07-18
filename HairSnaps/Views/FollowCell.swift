//
//  FollowCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// FollowCellDelegate Protocol;
protocol FollowCellDelegate: NSObjectProtocol {
    func didSelectUser(user: User!)
    func didFollowUser(user: User!)
}

// FollowCell Class;
class FollowCell: UITableViewCell {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!

    weak var delegate: FollowCellDelegate! = nil
    
    weak var user: User! {
        didSet {
            // Photo;
            photoButton.sd_setImageWithURL(NSURL(string: user.photo), forState: UIControlState.Normal, placeholderImage: UIImage(named: "profile_placholder"))
            
            // User;
            usernameLabel.text = user.username
            
            // Name;
            nameLabel.text = user.name
            
            // Follow;
            followButton.hidden = user.id == Account.me.id
            followButton.selected = user.followed != 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Photo;
        photoButton.layer.borderWidth = 2
        photoButton.layer.borderColor = UIColor(red: 177.0 / 255.0, green: 177.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0).CGColor
        photoButton.layer.cornerRadius = 21
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onBtnPhoto(sender: AnyObject) {
        if (delegate.respondsToSelector("didSelectUser:")) {
            delegate.didSelectUser(user)
        }
    }
    
    @IBAction func onBtnFollow(sender: AnyObject) {
        if (delegate.respondsToSelector("didFollowUser:")) {
            delegate.didFollowUser(user)
        }
    }
}
