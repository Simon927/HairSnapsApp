//
//  PriceViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PriceViewController Class;
class PriceViewController: UITableViewController {

    var prices: NSMutableArray! = NSMutableArray()
    var selectedRow: Int = -1
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadPrices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return loading == true ? 1 : prices.count
            
        case 1:
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
        case 0:
            if (loading) {
                // Cell;
                var cell = tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as UITableViewCell
                return cell
            } else {
                // Price;
                let price = prices[indexPath.row] as Price
                
                // Cell;
                var cell = tableView.dequeueReusableCellWithIdentifier("PriceCell", forIndexPath: indexPath) as UITableViewCell
                cell.accessoryType = selectedRow == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
                cell.textLabel?.text =  NSString(format: "$%d - $%d", price.min_price, price.max_price )
                return cell
            }
            
        case 1:
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("AddPriceCell", forIndexPath: indexPath) as UITableViewCell
            return cell
            
        default:
            break
        }
        
        return nil as UITableViewCell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section) {
        case 0:
            if (!loading) {
                // Selected Row;
                selectedRow = selectedRow != indexPath.row ? indexPath.row : -1
                
                // Reload;
                tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            }
            break
            
        default:
            break
        }
    }
    
    func loadPrices() {
        // Posts;
        APIClient.sharedClient.prices({ (prices) -> Void in
            // Loading;
            self.loading = false
            
            // Add Prices;
            self.prices.addObjectsFromArray(prices)
            
            // Reload;
            self.tableView.reloadData()
        })
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnDone(sender: AnyObject) {
        // Set
        let postController = self.navigationController as PostNavigationController
        
        // Price;
        if (selectedRow != -1) {
            postController.price = prices[selectedRow] as Price
        } else {
            postController.price = nil
        }
        
        // Own Price;
        postController.ownPrice = nil
        
        // Pop;
        postController.popToRootViewControllerAnimated(true)
    }
}
