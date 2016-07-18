//
//  FollowerViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// FollowerViewController Class;
class FollowerViewController: UITableViewController, FollowCellDelegate {

    weak var user: User! = nil
    
    var followers: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View;
        tableView.tableFooterView = UIView()
        
        // Load;
        loadFollowers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowCell", forIndexPath: indexPath) as FollowCell
        cell.delegate = self        
        cell.user = followers[indexPath.row] as User
        return cell
    }
    
    func didSelectUser(user: User!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("UserViewController") as UserViewController
        viewController.user = user
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didFollowUser(user: User!) {
        
    }
    
    func loadFollowers() {
        APIClient.sharedClient.followers(user, completion: { (followers) -> Void in
            // Remove All Posts;
            self.followers.removeAllObjects()
            
            // Add Posts;
            self.followers.addObjectsFromArray(followers)
            
            // Reload;
            self.tableView.reloadData()
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
