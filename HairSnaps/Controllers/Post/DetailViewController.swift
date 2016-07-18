//
//  DetailViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// DetailViewController Class;
class DetailViewController: UITableViewController {

    let colors = ["Blonde", "Brunette", "Black", "Red", "Gray"]
    let lengths = ["Pixie", "Short", "Shoulder Length", "Long"]
    let ocassions = ["Party", "Everyday", "Formal"]

    var color: Int = -1
    var length: Int = -1
    var ocassion: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:     // Colors;
            return "COLORS"
            
        case 1:     // Lengths;
            return "LENGTHS"
            
        case 2:     // Ocassions;
            return "OCASSIONS"
            
        case 3:     // Additional Tags;
            return "ADDITIONAL TAGS"
            
        default:
            break
        }
        
        return nil
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return colors.count
            
        case 1:
            return lengths.count
            
        case 2:
            return ocassions.count
            
        case 3:
            return 1
            
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
        case 0:     // Colors;
            var cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = color == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text = colors[indexPath.row]
            return cell

        case 1:     // Lengths;
            var cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = length == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text = lengths[indexPath.row]
            return cell

        case 2:     // Ocassions;
            var cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = ocassion == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text = ocassions[indexPath.row]
            return cell

        case 3:     // Additional Tags;
            var cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.textLabel?.text = "Create your own tags"
            return cell

        default:
            break
        }
        
        return nil as UITableViewCell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell: UITableViewCell! = nil
        
        switch (indexPath.section) {
        case 0:     // Color;
            // Selected Row;
            color = color != indexPath.row ? indexPath.row : -1
            
            // Reload;
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        case 1:     // Length;
            // Selected Row;
            length = length != indexPath.row ? indexPath.row : -1

            // Reload;
            tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        case 2:     // Ocasstion;
            // Selected Row;
            ocassion = ocassion != indexPath.row ? indexPath.row : -1
            
            // Reload;
            tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        case 3:
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("TagAddController") as TagAddController
            navigationController?.pushViewController(viewController, animated: true)
            break
            
        default:
            break
        }
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        // Set
        let postController = navigationController as PostNavigationController
        
        let values = NSMutableArray()
        
        // Color;
        if (color != -1) {
            values.addObject(colors[color])
        }
        
        // Length;
        if (length != -1) {
            values.addObject(lengths[length])
        }
        
        // Ocassion;
        if (ocassion != -1) {
            values.addObject(ocassions[ocassion])
        }
        
        // Detail
        postController.detail = values.componentsJoinedByString(",")
        
        // Pop;
        postController.popToRootViewControllerAnimated(true)
    }
}
