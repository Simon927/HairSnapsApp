//
//  OccasionFilterController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// OccasionFilterController Class;
class OccasionFilterController: UITableViewController {

    var occassions: NSMutableArray! = NSMutableArray()
    var selectedOccasions: [Bool] = []
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadOccasions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loading == true ? 1 : occassions.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (loading) {
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as UITableViewCell
            return cell
        } else {
            // Color;
            let color = occassions[indexPath.row] as Item
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("OccassionCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = selectedOccasions[indexPath.row] ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text =  color.name
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!loading) {
            // Selected Row;
            selectedOccasions[indexPath.row] = !selectedOccasions[indexPath.row]
            
            // Reload;
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func loadOccasions() {
        // Places;
        APIClient.sharedClient.occassions({ (occassions) -> Void in
            // Add;
            self.occassions.addObjectsFromArray(occassions)
            
            // Selected Rows;
            for occassion in occassions {
                self.selectedOccasions.append(true)
            }
            
            // Loading;
            self.loading = false
            
            // Reload;
            self.tableView.reloadData()
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnApply(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
