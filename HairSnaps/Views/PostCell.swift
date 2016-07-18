//
//  PostCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PostCellDelegate Protocol;
protocol PostCellDelegate: NSObjectProtocol {
    func didSelectUser(user: User!)
    func didLike(post: Post!)
}

// PostCell Class;
class PostCell: UICollectionViewCell {
   
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
    weak var delegate: PostCellDelegate! = nil
    
    weak var post: Post! {
        didSet {
            // Photo;
            let image = post.image as Image!
            photoView.sd_setImageWithURL(NSURL(string: post.image.large_retina), placeholderImage: UIImage())
            
            // User;
            let user = post.user as User!
            userButton.sd_setImageWithURL(NSURL(string: user.photo), forState: UIControlState.Normal, placeholderImage: UIImage(named: "profile_placholder"))

            // Liked;
            likeButton.selected = post.does_user_likes
            
            // Likes;
            likesLabel.text = String(post.user_likes_count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // User;
        userButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        userButton.layer.borderWidth = 2
        userButton.layer.borderColor = UIColor.whiteColor().CGColor
        userButton.layer.cornerRadius = 20
    }
    
    @IBAction func onBtnUser(sender: AnyObject) {
        if (delegate.respondsToSelector("didSelectUser:")) {
            delegate.didSelectUser(post.user)
        }
    }
    
    @IBAction func onBtnLike(sender: AnyObject) {
        if (delegate.respondsToSelector("didLike:")) {
            delegate.didLike(post)
        }
    }
}
