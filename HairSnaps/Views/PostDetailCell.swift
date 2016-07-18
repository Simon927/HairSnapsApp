//
//  PostDetailCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import Foundation
import CoreText

// --- Defines ---;
// PostDetailCellDelegate Protocol;
protocol PostDetailCellDelegate: NSObjectProtocol {
    func didLike(post: Post!)
    func didReport(post: Post!)
    func didShare(post: Post!)
    func didLocation(post: Post!)
    func didSalon(post: Post!)
    func didStylist(post: Post!)
    func didPrice(post: Post!)
    func didViewAllComments(post: Post!)
}

// PostDetailCell Class;
class PostDetailCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, TTTAttributedLabelDelegate {

    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var photoView: UICollectionView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var locationLabel: TTTAttributedLabel!
    @IBOutlet weak var salonLabel: TTTAttributedLabel!
    @IBOutlet weak var stylistLabel: TTTAttributedLabel!
    @IBOutlet weak var priceLabel: TTTAttributedLabel!

    @IBOutlet weak var captionHeight: NSLayoutConstraint!
    @IBOutlet weak var captionLabel: UILabel!

    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagHeight: NSLayoutConstraint!
    
    @IBOutlet weak var commentsButton: UIButton!
    
    weak var delegate: PostDetailCellDelegate! = nil
    weak var post: Post! {
        didSet {
            // User;
            userButton.sd_setImageWithURL(NSURL(string: post.user.photo), forState: UIControlState.Normal, placeholderImage: UIImage(named: "profile_placholder"))
            usernameLabel.text = post.user.name
            
            // Date;
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date: NSDate! = formatter.dateFromString(post.created_at)
            
            formatter.dateFormat = "MMMM. dd, yyyy"
            formatter.dateStyle = NSDateFormatterStyle.MediumStyle
            let dateString: String! = formatter.stringFromDate(date)
            
            dateLabel.text = dateString
            
            // Remove All Photos;
            photos.removeAllObjects()
            
            // Front;
            if (post.image != nil) {
                photos.addObject(post.image.large_retina)
            }

            // Side 1;
            if (post.image1 != nil) {
                photos.addObject(post.image1.large_retina)
            }

            // Side 2;
            if (post.image2 != nil) {
                photos.addObject(post.image2.large_retina)
            }
            
            // Back;
            if (post.image3 != nil) {
                photos.addObject(post.image3.large_retina)
            }
            
            photoView.reloadData()
            
            // Pages;
            pageView.hidden = photos.count > 1 ? false : true
            pageControl.currentPage = 0
            pageControl.numberOfPages = photos.count

            // Likes;
            
            // Location;
            if (post.location != nil) {
               let range: NSRange = NSMakeRange(0, post.location.name.utf16Count)
                
                locationLabel.text = post.location.name
                locationLabel.addLinkToURL(NSURL(string: "location"), withRange: range)
            }
            
            // Salon;
            if (post.salon != nil) {
                let range: NSRange = NSMakeRange(0, post.salon.name.utf16Count)
                
                salonLabel.text = post.salon.name
                salonLabel.addLinkToURL(NSURL(string: "salon"), withRange: range)
            } else {
                salonLabel.text = "N/A"
            }
            
            // Stylist;
            if (post.stylist != nil) {
                let range: NSRange = NSMakeRange(0, post.stylist.name.utf16Count)
                
                stylistLabel.text = post.stylist.name
                stylistLabel.addLinkToURL(NSURL(string: "stylist"), withRange: range)
            } else {
                stylistLabel.text = "N/A"
            }
            
            // Price;
            if (post.price != "" && post.min_price != "") {
                let text = NSString(format: "$%d-$%d", post.min_price, post.price)
                let range: NSRange = NSMakeRange(0, text.length)
                
                priceLabel.text = text
                priceLabel.addLinkToURL(NSURL(string: "price"), withRange: range)

            } else {
                priceLabel.text = "N/A"
            }
            
            // Caption;
            if (post.caption != "") {
                captionLabel.text = post.caption
            }
            
            captionHeight.constant = 0
            
            // Tags;
            if (post.tags != nil && post.tags.count > 0) {
                
                var margin: CGFloat = 8
                var lineWidth: CGFloat = CGRectGetWidth(UIScreen.mainScreen().bounds) - margin * 2
                var font = UIFont.systemFontOfSize(15)
                var size = CGSize(width: lineWidth, height: CGFloat.max)
                var attributes = [
                    NSFontAttributeName: font
                ]

                var x: CGFloat = margin, y: CGFloat = margin
                var width: CGFloat = 0, height: CGFloat = 32

                for subview in tagView.subviews {
                    if (subview.isKindOfClass(UIButton)) {
                        subview.removeFromSuperview()
                    }
                }
                
                for tag in post.tags {
                    let title = tag as NSString
                    let rect = title.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
                    
                    width = min(lineWidth, CGRectGetWidth(rect) + margin * 2)
                    
                    if (x + width > lineWidth) {
                        x = margin
                        y = y + height + margin
                    }
                    
                    let tagFrame = CGRect(x: x, y: y, width: width, height: height)
                    
                    x = x + width + margin
                    
                    let tagButton: UIButton! = UIButton()
                    tagButton.titleLabel?.font = font
                    tagButton.setTitle(title, forState: UIControlState.Normal)
                    tagButton.frame = tagFrame
                    
                    let backgroundColor = UIColor(red: 218.0 / 255.0, green: 245.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
                    tagButton.backgroundColor = backgroundColor
                    
                    let titleColor = UIColor(red: 82.0 / 255.0, green: 196.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
                    tagButton.setTitleColor(titleColor, forState: UIControlState.Normal)
                    
                    tagButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
                    
                    tagButton.layer.cornerRadius = 4
                    
                    tagView.addSubview(tagButton)
                }
                
                tagHeight.constant = y + height + margin
            } else {
                tagHeight.constant = 0
            }
            
            // Comments;
            commentsButton.setTitle(NSString(format: "%d comments", post.user_comments_count), forState: UIControlState.Normal)
        }
    }
    
    var photos: NSMutableArray! = NSMutableArray()
    
    class func heightForPost(post: Post!) -> CGFloat {
        var cellHeight: CGFloat = 686
        
        var margin: CGFloat = 8
        var lineWidth: CGFloat = CGRectGetWidth(UIScreen.mainScreen().bounds) - margin * 2
        
        var font = UIFont.systemFontOfSize(15)
        var size = CGSize(width: lineWidth, height: CGFloat.max)
        var attributes = [
            NSFontAttributeName: font
        ]
        
        // Caption;
        if (post.caption != "") {
            let rect = post.caption.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
            cellHeight = cellHeight + max(44, CGRectGetHeight(rect) + margin * 2)
        }
        
        // Tags;
        if (post.tags != nil && post.tags.count > 0) {
            var x: CGFloat = margin, y: CGFloat = margin
            var width: CGFloat = 0, height: CGFloat = 32
            
            for tag in post.tags {
                let title = tag as NSString
                let rect = title.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
                
                width = min(lineWidth, CGRectGetWidth(rect) + margin * 2)
                
                if (x + width > lineWidth) {
                    x = margin
                    y = y + height + margin
                }
                
                x = x + width + margin
            }
            
            cellHeight = cellHeight + y + height + margin
        }
        
        return cellHeight
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // User;
        userButton.layer.borderWidth = 2
        userButton.layer.borderColor = UIColor.whiteColor().CGColor
        userButton.layer.cornerRadius = 16
        
        // Labels;
        let color = UIColor(red: 82.0 / 255.0, green: 196.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
        
        let linkAttributes = [
            String(kCTUnderlineStyleAttributeName): NSNumber(int: CTUnderlineStyle.None.rawValue),
            String(kCTForegroundColorAttributeName): color.CGColor
        ]
        let activeLinkAttributes = [
            String(kCTUnderlineStyleAttributeName): NSNumber(int: CTUnderlineStyle.None.rawValue),
            String(kCTForegroundColorAttributeName): UIColor.blueColor().CGColor
        ]
        
        locationLabel.delegate = self
        locationLabel.linkAttributes = linkAttributes
        locationLabel.activeLinkAttributes = activeLinkAttributes

        salonLabel.delegate = self
        salonLabel.linkAttributes = linkAttributes
        salonLabel.activeLinkAttributes = activeLinkAttributes

        stylistLabel.delegate = self
        stylistLabel.linkAttributes = linkAttributes
        stylistLabel.activeLinkAttributes = activeLinkAttributes

        priceLabel.delegate = self
        priceLabel.linkAttributes = linkAttributes
        priceLabel.activeLinkAttributes = activeLinkAttributes
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = photoView.dequeueReusableCellWithReuseIdentifier("PostPhotoCell", forIndexPath: indexPath) as PostPhotoCell
        cell.photo = photos[indexPath.row] as String
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return photoView.bounds.size
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageControl.currentPage = Int(photoView.contentOffset.x / photoView.bounds.width)
    }
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        if (url.absoluteString == "location") {
            if (delegate.respondsToSelector("didLocation:")) {
                delegate.didLocation(post)
            }
        } else if (url.absoluteString == "salon") {
            if (delegate.respondsToSelector("didSalon:")) {
                delegate.didSalon(post)
            }
        } else if (url.absoluteString == "stylist") {
            if (delegate.respondsToSelector("didStylist:")) {
                delegate.didStylist(post)
            }
        } else if (url.absoluteString == "price") {
            if (delegate.respondsToSelector("didPrice:")) {
                delegate.didPrice(post)
            }
        }
    }
    
    @IBAction func onBtnLike(sender: AnyObject) {
        if (delegate.respondsToSelector("didLike:")) {
            delegate.didLike(post)
        }
    }
    
    @IBAction func onBtnReport(sender: AnyObject) {
        if (delegate.respondsToSelector("didReport:")) {
            delegate.didReport(post)
        }
    }
    
    @IBAction func onBtnShare(sender: AnyObject) {
        if (delegate.respondsToSelector("didShare:")) {
            delegate.didShare(post)
        }
    }
    
    @IBAction func onBtnViewAllComments(sender: AnyObject) {
        if (delegate.respondsToSelector("didViewAllComments:")) {
            delegate.didViewAllComments(post)
        }
    }
}
