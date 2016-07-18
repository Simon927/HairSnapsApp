//
//  WalkthroughPostController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// WalkthroughPostController Class;
class WalkthroughPostController: UITableViewController, PostDetailCellDelegate, CommentPostCellDelegate, WalkthroughPopupDelegate {
    
    weak var post: Post!
    
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
            cell.comment = comment
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
    
    func didLike(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPopupController") as WalkthroughPopupController
        viewController.delegate = self
        viewController.showController(self)
    }
    
    func didReport(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPopupController") as WalkthroughPopupController
        viewController.delegate = self
        viewController.showController(self)
    }
    
    func didShare(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPopupController") as WalkthroughPopupController
        viewController.delegate = self
        viewController.showController(self)
    }
    
    func didLocation(post: Post!) {
        
    }
    
    func didSalon(post: Post!) {
        
    }
    
    func didStylist(post: Post!) {
        
    }
    
    func didPrice(post: Post!) {
        
    }
    
    func didViewAllComments(post: Post!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPopupController") as WalkthroughPopupController
        viewController.delegate = self
        viewController.showController(self)
    }
    
    func didBeginEditing() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPopupController") as WalkthroughPopupController
        viewController.delegate = self
        viewController.showController(self)
    }
    
    func didEndEditing() {
        
    }
    
    func didClose(controller: WalkthroughPopupController!) {
        // Hide;
        controller.hideController()
    }
    
    func didLogin(controller: WalkthroughPopupController!) {
        // Hide;
        controller.hideController()
        
        // Login;
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("SignViewController") as SignViewController
        viewController.navigationItem.title = "LOG IN"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didRegister(controller: WalkthroughPopupController!) {
        // Hide;
        controller.hideController()

        // Register;
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("SignViewController") as SignViewController
        viewController.navigationItem.title = "SIGN UP"
        navigationController?.pushViewController(viewController, animated: true)
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
