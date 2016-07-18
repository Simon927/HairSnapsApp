//
//  FollowingViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// FollowingViewController Class;
class FollowingViewController: UITableViewController, FollowCellDelegate {

    weak var user: User! = nil
    
    var followings: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View;
        tableView.tableFooterView = UIView()
        
        // Load;
        loadFollowings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followings.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowCell", forIndexPath: indexPath) as FollowCell
        cell.delegate = self
        cell.user = followings[indexPath.row] as User
        return cell
    }
    
    func didSelectUser(user: User!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("UserViewController") as UserViewController
        viewController.user = user
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didFollowUser(user: User!) {
        
    }
    
    func loadFollowings() {
        APIClient.sharedClient.followings(user, completion: { (followings) -> Void in
            // Remove All Posts;
            self.followings.removeAllObjects()
            
            // Add Posts;
            self.followings.addObjectsFromArray(followings)
            
            // Reload;
            self.tableView.reloadData()
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
