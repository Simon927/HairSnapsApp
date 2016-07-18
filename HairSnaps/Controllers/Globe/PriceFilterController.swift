//
//  PriceFilterController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PriceFilterController Class;
class PriceFilterController: UITableViewController {

    var prices: NSMutableArray! = NSMutableArray()
    var selectedPrices: [Bool] = []
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadPrices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loading == true ? 1 : prices.count
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
            // Price;
            let price = prices[indexPath.row] as Price
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("PriceCell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = selectedPrices[indexPath.row] ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            cell.textLabel?.text =  NSString(format: "$%d - $%d", price.min_price, price.max_price )
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!loading) {
            // Selected Row;
            selectedPrices[indexPath.row] = !selectedPrices[indexPath.row]
            
            // Reload;
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func loadPrices() {
        // Places;
        APIClient.sharedClient.prices({ (prices) -> Void in
            // Add;
            self.prices.addObjectsFromArray(prices)
            
            // Selected Rows;
            for price in prices {
                self.selectedPrices.append(true)
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
