//
//  TagAddController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// TagAddController Class;
class TagAddController: UIViewController, RMSTokenDelegate {

    @IBOutlet weak var tokenView: RMSTokenView!
    @IBOutlet weak var tagView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Token View;
        tokenView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tokenView(tokenView: RMSTokenView!, didChangeText text: String!) {
        
    }
    
    func tokenView(tokenView: RMSTokenView!, shouldAddTokenWithText text: String!) -> Bool {
        if (text == nil || text == " ") {
            return false
        }
        
        return true
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        // Pop;
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        // Set
        let postController = navigationController as PostNavigationController
        
        // Pop;
        postController.popToRootViewControllerAnimated(true)
    }
}
