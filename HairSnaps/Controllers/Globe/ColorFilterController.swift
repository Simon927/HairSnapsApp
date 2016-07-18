//
//  ColorFilterController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ColorFilterController Class;
class ColorFilterController: UITableViewController {

    var colors: NSMutableArray! = NSMutableArray()
    var selectedColors: [Bool] = []
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadColors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loading == true ? 1 : colors.count
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
            let color = colors[indexPath.row] as Item
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = selectedColors[indexPath.row] ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text =  color.name
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!loading) {
            // Selected Row;
            selectedColors[indexPath.row] = !selectedColors[indexPath.row]
            
            // Reload;
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func loadColors() {
        // Places;
        APIClient.sharedClient.colors({ (colors) -> Void in
            // Add;
            self.colors.addObjectsFromArray(colors)
            
            // Selected Rows;
            for color in colors {
                self.selectedColors.append(true)
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
