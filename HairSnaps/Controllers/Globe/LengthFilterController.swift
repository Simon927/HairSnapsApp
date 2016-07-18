//
//  LengthFilterController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// LengthFilterController Class;
class LengthFilterController: UITableViewController {

    var lengths: NSMutableArray! = NSMutableArray()
    var selectedLengths: [Bool] = []
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadLengths()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loading == true ? 1 : lengths.count
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
            // Lengths;
            let length = lengths[indexPath.row] as Item
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("LengthCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = selectedLengths[indexPath.row] ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text =  length.name
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!loading) {
            // Selected Row;
            selectedLengths[indexPath.row] = !selectedLengths[indexPath.row]
            
            // Reload;
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func loadLengths() {
        // Places;
        APIClient.sharedClient.lengths({ (lengths) -> Void in
            // Add;
            self.lengths.addObjectsFromArray(lengths)
            
            // Selected Rows;
            for length in lengths {
                self.selectedLengths.append(true)
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
