//
//  SalonResultController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// SalonResultController Class;
class SalonResultController: UITableViewController {

    var filter: String! = ""
    
    var places: NSMutableArray! = NSMutableArray()
    var loading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadPlaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (loading) {
            return 1
        } else {
            return places.count > 0 ? places.count : 1
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (loading) {
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = "Searching..."
            return cell
        } else if (places.count == 0){
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = "No Result."
            return cell
        } else {
            // Place;
            let place = places[indexPath.row] as Place
            
            // Cell;
            var cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = place.name
            cell.detailTextLabel?.text = place.address
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (places.count > 0) {
            let place = places[indexPath.row] as Place
            
            // Load;
            loadPlace(place)
        }
    }
    
    func loadPlaces() {
        // Coordinate;
        let coordinate = LocationClient.sharedClient.location.coordinate
        
        // Places;
        LocationClient.sharedClient.places(nearby: coordinate, type: "", keyword: filter, completion: { (places, nextPageToken) -> Void in
            // Remove All Objects;
            self.places.removeAllObjects()
            
            // Add;
            self.places.addObjectsFromArray(places)
            
            // Loading;
            self.loading = false
            
            // Reload;
            self.tableView.reloadData()
        })
    }
    
    func loadPlace(place: Place) {
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Place;
        LocationClient.sharedClient.place(place, completion: { (successed) -> Void in
            // Hide;
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            // Set
            let postController = self.navigationController as PostNavigationController
            postController.salon = place
            
            // Pop;
            postController.popToRootViewControllerAnimated(true)
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
