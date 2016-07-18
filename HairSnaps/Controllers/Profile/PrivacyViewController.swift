//
//  PrivacyViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Privacy Policy;
let kPrivacyPolicyURLString = "http://www.hairsnaps.com/Privacy.html"

// PrivacyViewController Class;
class PrivacyViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        let url: NSURL! = NSURL(string: kPrivacyPolicyURLString)
        let urlRequst: NSURLRequest! = NSURLRequest(URL: url)
        
        webView.loadRequest(urlRequst)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
