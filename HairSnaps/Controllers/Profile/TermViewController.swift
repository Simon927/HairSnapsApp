//
//  TermViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Terms of Use;
let kTermsOfUseURLString = "http://www.hairsnaps.com/TermsfoUse.html"

// TermViewController Class;
class TermViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        let url: NSURL! = NSURL(string: kTermsOfUseURLString)
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
