//
//  NotificationViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// NotificationViewController Class;
class NotificationViewController: UITableViewController {

    let notifications = ["Off", "Only people I follow", "Everyone"]
    let comments = ["Off", "Only people I follow", "Everyone"]
    let followers = ["Off", "All new poeple"]
    
    var notification: Int = -1
    var comment: Int = -1
    var follower: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:     // Notifications;
            return "NOTIFICATIONS"
            
        case 1:     // Comments;
            return "COMMENTS"
            
        case 2:     // Your New Followers;
            return "YOUR NEW FOLLOWERS"
            
        default:
            break
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return notifications.count
            
        case 1:
            return comments.count
            
        case 2:
            return followers.count
            
        default:
            break
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:     // Notifications;
            var cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = notification == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text = notifications[indexPath.row]
            return cell
            
        case 1:     // Comments;
            var cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = comment == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text = comments[indexPath.row]
            return cell
            
        case 2:     // Your New Followers;
            var cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = follower == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text = followers[indexPath.row]
            return cell
            
        default:
            break
        }
        
        return nil as UITableViewCell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell: UITableViewCell! = nil
        
        switch (indexPath.section) {
        case 0:     // Notifications;
            // Selected Row;
            notification = notification != indexPath.row ? indexPath.row : -1
            
            // Reload;
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        case 1:     // Comments;
            // Selected Row;
            comment = comment != indexPath.row ? indexPath.row : -1
            
            // Reload;
            tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        case 2:     // Your New Followers;
            // Selected Row;
            follower = follower != indexPath.row ? indexPath.row : -1
            
            // Reload;
            tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        default:
            break
        }
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
