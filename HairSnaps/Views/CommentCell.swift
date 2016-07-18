//
//  CommentCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// CommentCellDelegate Protocol;
protocol CommentCellDelegate: NSObjectProtocol {
    func didSelectUser(user: User!)
    func didSelectUsername(username: String!)
    func didSelectKeyword(keyword: String!)
}

// CommentCell Class;
class CommentCell: SWTableViewCell, TTTAttributedLabelDelegate {

    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var commentLabel: TTTAttributedLabel!
    
    weak var commentDelegate: CommentCellDelegate! = nil
    
    weak var comment: Comment! {
        didSet {
            // User;
            userButton.sd_setImageWithURL(NSURL(string: comment.user.photo), forState: UIControlState.Normal, placeholderImage: UIImage(named: "profile_placholder"))

            // Comment;
            commentLabel.text = comment.user.username + ": " + comment.body
            
            // Username;
            let usernameRange = NSMakeRange(0, comment.user.username.utf16Count)
            let urlPath = "poster:" + comment.user.username
            let url = NSURL(string: urlPath)
            
            commentLabel.addLinkToURL(url, withRange: usernameRange)
            
            // Attributed String;
            let mas: NSMutableAttributedString! = commentLabel.attributedText.mutableCopy() as NSMutableAttributedString
            let masRange: NSRange = NSMakeRange(0, mas.length)

            // Usernames;
            let userRegex: NSRegularExpression! = NSRegularExpression(pattern: "\\B@\\w+", options: NSRegularExpressionOptions.CaseInsensitive , error: nil)
            
            userRegex.enumerateMatchesInString(mas.string, options: nil, range: masRange, usingBlock: { (result: NSTextCheckingResult!, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                // Range;
                let start = advance(mas.string.startIndex, result.range.location)
                let end = advance(mas.string.startIndex, result.range.location + result.range.length)
                let range = Range<String.Index>(start: start, end: end)
                
                // String;
                let string = mas.string.substringWithRange(range)
                let location = advance(string.startIndex, 1)
                let urlPath = "user:" + string.substringFromIndex(location)
                let url = NSURL(string: urlPath)
                
                self.commentLabel.addLinkToURL(url, withRange: result.range)
            })
            
            // Keywords;
            let keyRegex: NSRegularExpression! = NSRegularExpression(pattern: "\\B#\\w+", options: NSRegularExpressionOptions.CaseInsensitive , error: nil)
            
            keyRegex.enumerateMatchesInString(mas.string, options: nil, range: masRange, usingBlock: { (result: NSTextCheckingResult!, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                // Range;
                let start = advance(mas.string.startIndex, result.range.location)
                let end = advance(mas.string.startIndex, result.range.location + result.range.length)
                let range = Range<String.Index>(start: start, end: end)

                // String;
                let string = mas.string.substringWithRange(range)
                let location = advance(string.startIndex, 1)
                let urlPath = "keyword:" + string.substringFromIndex(location)
                let url = NSURL(string: urlPath)
                
                self.commentLabel.addLinkToURL(url, withRange: result.range)
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // User;
        userButton.layer.borderWidth = 2
        userButton.layer.borderColor = UIColor.whiteColor().CGColor
        userButton.layer.cornerRadius = 16
        
        userButton.layer.borderWidth = 2
        userButton.layer.borderColor = UIColor.whiteColor().CGColor
        userButton.layer.cornerRadius = 16
        
        // Comment;
        let color = UIColor(red: 82.0 / 255.0, green: 196.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
        let linkAttributes = [
            String(kCTUnderlineStyleAttributeName): NSNumber(int: CTUnderlineStyle.None.rawValue),
            String(kCTForegroundColorAttributeName): color.CGColor
        ]
        let activeLinkAttributes = [
            String(kCTUnderlineStyleAttributeName): NSNumber(int: CTUnderlineStyle.None.rawValue),
            String(kCTForegroundColorAttributeName): UIColor.blackColor().CGColor
        ]
        
        commentLabel.delegate = self
        commentLabel.linkAttributes = linkAttributes
        commentLabel.activeLinkAttributes = activeLinkAttributes
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        if (url.absoluteString == "poster") {
            if (commentDelegate.respondsToSelector("didSelectUser:")) {
                commentDelegate.didSelectUser(comment.user)
            }
        } else if (url.absoluteString == "user") {
            if (commentDelegate.respondsToSelector("didSelectUsername:")) {
                commentDelegate.didSelectUsername("")
            }
            
        } else if (url.absoluteString == "keyword") {
            if (commentDelegate.respondsToSelector("didSelectKeyword:")) {
                commentDelegate.didSelectKeyword("")
            }
        }
    }
}
