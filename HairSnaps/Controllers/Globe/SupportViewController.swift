//
//  SupportViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// SupportViewController Class;
class SupportViewController: UITableViewController {

    @IBOutlet weak var reportText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Report Text;
        reportText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnReport(sender: AnyObject) {
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Load;
        let reportController = navigationController as ReportNavigationController
        let post = reportController.post
        
        // Report;
        APIClient.sharedClient.reportPost(post, message: reportText.text, completion: { (successed) -> Void in
            // Hide;
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if (successed) {
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            } else {
                
            }
        })
    }
}
