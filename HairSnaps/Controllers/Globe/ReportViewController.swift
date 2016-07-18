//
//  ReportViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ReportViewController Class;
class ReportViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row) {
        case 0, 1, 2, 3, 4:
            // Deselect;
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            // Report;
            report(indexPath.row)
            break
            
        default:
            break
        }
    }
    
    func report(index: Int) {
        let messages = ["Nudity, pornography, illegal activity", "Unrelated to HairSnaps", "Intellectual Property Violation", "Spam or Scam", "I dont like this photo of me", "Other"]
        let message = messages[index] as String
        
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Load;
        let reportController = navigationController as ReportNavigationController
        let post = reportController.post
        
        // Report;
        APIClient.sharedClient.reportPost(post, message: message, completion: { (successed) -> Void in
            // Hide;
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if (successed) {
                // Alert;
                UIAlertView(title: "", message: "Your report has been submitted. Thank You!", delegate: nil, cancelButtonTitle: "Okay").show()
                
                // Dismiss;
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            } else {
                
            }
        })
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
