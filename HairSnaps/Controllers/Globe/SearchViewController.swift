//
//  SearchViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// SearchViewController Class;
class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // Resign;
        searchBar.resignFirstResponder()
        
        // Search Result;
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("SearchResultController") as SearchResultController
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
