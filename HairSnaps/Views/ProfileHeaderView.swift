//
//  ProfileHeaderView.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ProfileHeaderDelegate Protocol;
protocol ProfileHeaderDelegate: NSObjectProtocol {
    func didFollowings()
    func didFollowers()
    func didLikes()
    func didTags()
}

// ProfileHeaderView Class;
class ProfileHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var salonLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var photoButton: DetailButton!
    @IBOutlet weak var followingButton: DetailButton!
    @IBOutlet weak var followerButton: DetailButton!
    @IBOutlet weak var likeButton: DetailButton!
    @IBOutlet weak var tagButton: DetailButton!
    
    weak var delegate: ProfileHeaderDelegate! = nil
    weak var user: User! {
        didSet {
            // Photo;
            photoView.sd_setImageWithURL(NSURL(string: user.photo), placeholderImage: UIImage(named: "profile_placholder"))
            
            // Name;
            nameLabel.text = user.firstName + " " + user.lastName
            
            // Address;
//          addressLabel.text = user.city + "," + user.state
            
            // Salon;
            salonLabel.text = user.stylistSalonName
            
            // Phone;
            phoneLabel.text = user.phone
            
            // Bio;
            bioLabel.text = user.bio
            
            // Photos;
            photoButton.additionalSubtitleLabel.text = String(user.numberOfPosts)
            
            // Followings;
            followingButton.additionalSubtitleLabel.text = String(user.numberOfFollowings)
            
            // Followers;
            followerButton.additionalSubtitleLabel.text = String(user.numberOfFollowers)
            
            // Likes;
            likeButton.additionalSubtitleLabel.text = String(user.numberOfLikes)
            
            // Tags;
            tagButton.additionalSubtitleLabel.text = String(user.numberOfTags)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Photo View;
        photoView.layer.borderWidth = 2
        photoView.layer.borderColor = UIColor.grayColor().CGColor
        photoView.layer.cornerRadius = 54
        
        // Photos;
        photoButton.setTitle("PHOTOS", andSubtitle: "0")
        
        // Followings;
        followingButton.setTitle("FOLLOWINGS", andSubtitle: "0")
        
        // Followers;
        followerButton.setTitle("FOLLOWERS", andSubtitle: "0")
        
        // Likes;
        likeButton.setTitle("LIKES", andSubtitle: "0")
        
        // Tags;
        tagButton.setTitle("POST TAGS", andSubtitle: "0")
    }
    
    @IBAction func onBtnFollowings(sender: AnyObject) {
        if (delegate.respondsToSelector("didFollowings")) {
            delegate.didFollowings()
        }
    }
    
    @IBAction func onBtnFollowers(sender: AnyObject) {
        if (delegate.respondsToSelector("didFollowers")) {
            delegate.didFollowers()
        }
    }
    
    @IBAction func onBtnLikes(sender: AnyObject) {
        if (delegate.respondsToSelector("didLikes")) {
            delegate.didLikes()
        }
    }
    
    @IBAction func onBtnTags(sender: AnyObject) {
        if (delegate.respondsToSelector("didTags")) {
            delegate.didTags()
        }
    }
}
