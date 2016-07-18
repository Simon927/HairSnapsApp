//
//  SignNavigationController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// SignNavigationController Class;
class SignNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Root Controller;
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if (!userDefaults.boolForKey("first")) {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughViewController") as WalkthroughViewController
            viewControllers = [viewController]
        } else {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("SplashViewController") as SplashViewController
            viewControllers = [viewController]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
