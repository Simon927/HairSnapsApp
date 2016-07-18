//
//  CommunityViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// CommunityViewController Class;
class CommunityViewController: UITableViewController, UIActionSheetDelegate, UIAlertViewDelegate, CommunityCellDelegate {
    
    var posts: NSMutableArray! = NSMutableArray()
    var selectedPost: Post! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Full Screen;
/*      fullScreenScroll = YIFullScreenScroll(viewController: self, scrollView: tableView, style: YIFullScreenScrollStyle.Facebook)
        fullScreenScroll.additionalOffsetYToStartShowing = 0
        fullScreenScroll.additionalOffsetYToStartHiding = 0
        */
        
        
        // Refresh Control;
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "loadPosts", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
        
        // Load;
        dispatch_after(1, dispatch_get_main_queue(), {
            self.loadPosts()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let post = posts[indexPath.row] as Post
        return CommunityCell.heightForPost(post)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CommunityCell", forIndexPath: indexPath) as CommunityCell
        cell.delegate = self
        cell.post = posts[indexPath.row] as Post
        return cell
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        switch (actionSheet.tag) {
        case 1:     // Report;
            switch (buttonIndex) {
            case 1:     // Report;
                let viewController = storyboard?.instantiateViewControllerWithIdentifier("ReportNavigationController") as UINavigationController
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
            switch (buttonIndex) {
            case 1:     // Facebook;
                break
                
            case 2:     // Twitter;
                break
                
            case 3:     // Pinterest;
                break
                
            case 4:     // Save to Camera Roll;
                break
                
            default:
                break
            }
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
            APIClient.sharedClient.deletePost(selectedPost, completion: { (successed) -> Void in
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
    
    func didLike(post: Post!) {

    }
    
    func didReport(post: Post!) {
        // Post;
        selectedPost = post;

        // Action Sheet;
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
        // Post;
        selectedPost = post;
        
        // Action Sheet;
        let actionSheet = UIActionSheet(title: "Share this photo", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Facebook", "Twitter", "Pinterest", "Save to Camera Roll")
        actionSheet.tag = 3
        actionSheet.showInView(view)
    }
    
    func didViewAllComments(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("CommentViewController") as CommentViewController
        viewController.post = post
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func loadPosts() {
        // Refreshing;
        if (refreshControl?.refreshing == false) {
            refreshControl?.beginRefreshing()
        }
        
        // Posts;
        APIClient.sharedClient.streamPosts({ (posts) -> Void in
            // Remove All Posts;
            self.posts.removeAllObjects()
            
            // Add Posts;
            self.posts.addObjectsFromArray(posts)
            self.tableView.reloadData()

            // Refreshing;
            self.refreshControl?.endRefreshing()
        })
    }
}
