//
//  SalonViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// SalonViewController Class;
class SalonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate {

    @IBOutlet weak var placeView: UITableView!
    
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchPlaces()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == searchDisplayController?.searchResultsTableView) {
            return searchDisplayController?.searchBar.text != "" ? 2 : 0
        } else if (loading) {
            return 1
        } else {
            return places.count > 0 ? places.count : 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView == searchDisplayController?.searchResultsTableView) {
            var text: String! = searchDisplayController?.searchBar.text
            
            var cell: UITableViewCell! = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SearchCell")
            
            switch (indexPath.row) {
            case 0:
                cell.textLabel?.text = NSString(format: "Create \"%@\"", text != nil ? text : "")
                cell.detailTextLabel?.text = "Create a custom location"
                break
                
            case 1:
                cell.textLabel?.text = NSString(format: "Search for \"%@\"", text != nil ? text : "")
                cell.detailTextLabel?.text = "Search more places nearby"
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                break
                
            default:
                break
            }
            
            return cell
        } else if (loading) {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == searchDisplayController?.searchResultsTableView) {
            switch (indexPath.row) {
            case 0:     // Create;
                createPlace()
                break
                
            case 1:     // Search;
                searchPlaces()
                break
                
            default:
                break
            }
        } else {
            let place = places[indexPath.row] as Place
            
            // Load;
            loadPlace(place)
        }
    }
    
    func loadPlaces() {
        // Coordinate;
        let coordinate = LocationClient.sharedClient.location.coordinate
        
        // Places;
        LocationClient.sharedClient.places(nearby: coordinate, type: "", keyword: "", completion: { (places, nextPageToken) -> Void in
            // Remove All Objects;
            self.places.removeAllObjects()
            
            // Add;
            self.places.addObjectsFromArray(places)
            
            // Loading;
            self.loading = false
            
            // Reload;
            self.placeView.reloadData()
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
    
    func createPlace() {
        
    }
    
    func searchPlaces() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("SalonResultController") as SalonResultController
        viewController.filter = searchDisplayController?.searchBar.text
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
