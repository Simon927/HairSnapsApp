//
//  ActivityViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ActivityViewController Class;
class ActivityViewController: UITableViewController {
    
    var activities: NSMutableArray! = NSMutableArray()
    var more: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadActivities()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (activities.count == 0) {
            return 1
        } else if (more == true){
            return activities.count + 1
        } else {
            return activities.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (activities.count == 0 && indexPath.row == 0) {
            return tableView.boundsHeight - topLayoutGuide.length - bottomLayoutGuide.length
        } else {
            return 48.0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (activities.count == 0 && indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("NoActivityCell", forIndexPath: indexPath) as UITableViewCell
            return cell
        } else if (indexPath.row < activities.count) {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as ActivityCell
            cell.activity = activities[indexPath.row] as Activity
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as ActivityCell
            return cell
        }
    }
    
    func loadActivities() {
        // Activities;
        APIClient.sharedClient.activities({ (activities) -> Void in
            // Remove All Objects;
            self.activities.removeAllObjects()
            
            // Add;
            self.activities.addObjectsFromArray(activities)
            
            // Reload;
            self.tableView.reloadData()
        })
    }
    
    func loadMore() {
        // Activities;
        APIClient.sharedClient.activities({ (activities) -> Void in
            // Add;
            self.activities.addObjectsFromArray(activities)
            
            // Reload;
            self.tableView.reloadData()
        })
    }
}
