//
//  CommentViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// CommentViewController Class;
class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SWTableViewCellDelegate {

    @IBOutlet weak var commentView: UITableView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    weak var post: Post! = nil
    
    var comments: NSMutableArray! = NSMutableArray()
    var nextPageToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View;
        commentView.tableFooterView = UIView()
        
        // Load;
        loadComments()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Notification;
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(
            self,
            selector: "willShowKeyBoard:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        defaultCenter.addObserver(
            self,
            selector: "willHideKeyBoard:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Notification;
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hidesBottomBarWhenPushed() -> Bool {
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:     // More;
            return 0
            
        case 1:     // Comments;
            return comments.count
            
        default:
            break
        }
        
        return 0
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:     // More;
            break
            
        case 1:     // Comments;
            // Comment;
            let comment = comments[indexPath.row] as Comment
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as CommentCell
            cell.comment = comment
            cell.delegate = self
            cell.rightUtilityButtons = rightButtons()
            return cell
            
        default:
            break
        }
        
        return nil as UITableViewCell!
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
                let index = self.comments.indexOfObject(comment)
                let indexPath = NSIndexPath(forRow: index, inSection: 1)
                
                // Remove;
                self.comments.removeObject(comment)
                
                // Delete;
                self.commentView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
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
    
    func willShowKeyBoard(notification: NSNotification) {
        let userInfo: NSDictionary! = notification.userInfo
        let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        let frame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        // Animation;
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.bottomSpace.constant = frame.height
            self.view.layoutIfNeeded()
        })
    }
    
    func willHideKeyBoard(notification: NSNotification) {
        let userInfo: NSDictionary! = notification.userInfo
        let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        
        // Animation;
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.bottomSpace.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func loadComments() {
        APIClient.sharedClient.comments(post, completion: { (comments) -> Void in
            // Add;
            self.comments.addObjectsFromArray(comments)
            
            // Reload;
            self.commentView.reloadData()
            
            if (self.comments.count > 0) {
                let indexPath = NSIndexPath(forRow: self.comments.count - 1, inSection: 1)
                self.commentView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onBtnPost(sender: AnyObject) {
        // Comment;
        let comment = Comment()
        comment.user = Account.me
        comment.body = commentText.text
        
        // Add;
        comments.addObject(comment)
        
        // Insert;
        let index = comments.indexOfObject(comment)
        let indexPath = NSIndexPath(forRow: index, inSection: 1)
        commentView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
        // Clear;
        commentText.text = ""
        
        // Post;
        APIClient.sharedClient.postComment(comment, forPost: post) { (successed) -> Void in
            if (!successed) {
                
            } else {
                self.commentView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                self.commentView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
        }
    }
}
