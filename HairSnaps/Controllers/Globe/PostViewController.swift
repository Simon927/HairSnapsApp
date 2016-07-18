//
//  PostViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import Social

// --- Defines ---;
// PostViewController Class;
class PostViewController: UITableViewController, UIActionSheetDelegate, UIAlertViewDelegate, SWTableViewCellDelegate, PostDetailCellDelegate, CommentCellDelegate, CommentPostCellDelegate {
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadPost()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
            
        case 1:
            return post.comments.count
            
        case 2:
            return 1
            
        default:
            break
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return PostDetailCell.heightForPost(post)
            
        case 1:
            return 50
            
        case 2:
            return 50
            
        default:
            break
        }
        
        return 0.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("PostDetailCell", forIndexPath: indexPath) as PostDetailCell
            cell.delegate = self
            cell.post = post
            return cell
            
        case 1:
            // Comment;
            let comment = post.comments[indexPath.row] as Comment
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as CommentCell
            cell.commentDelegate = self
            cell.comment = comment
            cell.delegate = self
            cell.rightUtilityButtons = rightButtons()
            return cell
            
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("CommentPostCell", forIndexPath: indexPath) as CommentPostCell
            cell.delegate = self
            return cell
            
        default:
            break
        }
        
        return nil as UITableViewCell!
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        switch (actionSheet.tag) {
        case 1:     // Report;
            switch (buttonIndex) {
            case 1:     // Report;
                let viewController = storyboard?.instantiateViewControllerWithIdentifier("ReportNavigationController") as ReportNavigationController
                viewController.post = post
                presentViewController(viewController, animated: true, completion: nil)
                break
                
            default:
                break
            }
            break
            
        case 2:     // Delete;
            switch (buttonIndex) {
            case 1:     // Delete;
                let alertView = UIAlertView(title: "", message: "Are you sure you want to delete this post?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Yes")
                alertView.tag = 2
                alertView.show()
                break
                
            default:
                break
            }
            break
            
        case 3:     // Share;
            SDWebImageManager.sharedManager().downloadImageWithURL(nil, options: SDWebImageOptions(0), progress: { (receivedSize: Int, expectedSize: Int) -> Void in
                
            }, completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) -> Void in
                switch (buttonIndex) {
                case 1:     // Facebook;
                    self.postToFacebook()
                    break
                    
                case 2:     // Twitter;
                    self.postToTwitter()
                    break
                    
                case 3:     // Pinterest;
                    self.postToPinterest()
                    break
                    
                case 4:     // Save to Camera Roll;
                    self.saveToCameraRoll()
                    break
                    
                default:
                    break
                }
            })
            break
            
        default:
            break
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        switch (buttonIndex) {
        case 1:
            // Show;
            MBProgressHUD.showHUDAddedTo(view, animated: true)
            
            // Delete;
            APIClient.sharedClient.deletePost(post, completion: { (successed) -> Void in
                // Hide;
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                if (!successed) {
                    
                } else {
                    
                }
            })
            break
            
        default:
            break
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {

    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        let commentCell: CommentCell! = cell as CommentCell
        let comment = commentCell.comment
        
        switch (index) {
        case 0:     // Delete;
            // Hide;
            commentCell.hideUtilityButtonsAnimated(true)
            
            // Delete;
            APIClient.sharedClient.deleteComment(comment, completion: { (successed) -> Void in
                // Index;
                let index = self.post.comments.indexOfObject(comment)
                let indexPath = NSIndexPath(forRow: index, inSection: 1)
                
                // Remove;
                self.post.comments.removeObject(comment)
                
                // Delete;
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            })
            break
            
        default:
            break
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, scrollingToState state: SWCellState) {
        
    }
    
    func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
        return true
    }

    func swipeableTableViewCell(cell: SWTableViewCell!, canSwipeToState state: SWCellState) -> Bool {
        return true
    }
    
    func swipeableTableViewCellDidEndScrolling(cell: SWTableViewCell!) {
        
    }
    
    func rightButtons() -> [AnyObject]! {
        let buttons: NSMutableArray! = NSMutableArray()
        buttons.sw_addUtilityButtonWithColor(UIColor.redColor(), title: "Delete")
        return buttons;
    }
    
    func didLike(post: Post!) {
        
    }
    
    func didReport(post: Post!) {
        if (post.user.id != Account.me.id) {
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Report")
            actionSheet.tag = 1
            actionSheet.showInView(view)
            
        } else {
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Delete Post")
            actionSheet.tag = 2
            actionSheet.showInView(view)
        }
    }
    
    func didShare(post: Post!) {
        let actionSheet = UIActionSheet(title: "Share this photo", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Facebook", "Twitter", "Pinterest", "Save to Camera Roll")
        actionSheet.tag = 3
        actionSheet.showInView(view)
    }
    
    func didLocation(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as MapViewController
        viewController.location = post.location
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didSalon(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as MapViewController
        viewController.location = post.location
        viewController.salon = post.salon
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didStylist(post: Post!) {
        
    }
    
    func didPrice(post: Post!) {
        
    }
    
    func didViewAllComments(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("CommentViewController") as CommentViewController
        viewController.post = post
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didSelectUser(user: User!) {
        
    }
    
    func didSelectUsername(username: String!) {
        
    }
    
    func didSelectKeyword(keyword: String!) {
        
    }

    func didBeginEditing() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("CommentViewController") as CommentViewController
        viewController.post = post
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didEndEditing() {
        
    }
    
    func postToFacebook() {
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)) {
            let composeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//          composeViewController.addImage(nil)
            presentViewController(composeViewController, animated: true, completion: nil)
        }
    }
    
    func postToTwitter() {
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)) {
            let composeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//          composeViewController.addImage(nil)
            presentViewController(composeViewController, animated: true, completion: nil)
        }
    }
    
    func postToPinterest() {
        
    }
    
    func saveToCameraRoll() {
        UIImageWriteToSavedPhotosAlbum(nil, nil, nil, nil)
    }
    
    func loadPost() {
        APIClient.sharedClient.viewPost(post, completion: { (successed) -> Void in
            if (!successed) {
                
            } else {
                // Reload;
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
