//
//  PostNavigationController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PostNavigationController Class;
class PostNavigationController: UINavigationController, UINavigationControllerDelegate {

    var frontImage: UIImage! = nil
    var side1Image: UIImage! = nil
    var side2Image: UIImage! = nil
    var backImage: UIImage! = nil

    var salon: Place! = nil
    var stylist: User! = nil
    var price: Price! = nil
    var ownPrice: String! = nil
    var detail: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if (viewController.isKindOfClass(PostCreateController) == true) {
            viewControllers = [viewController]
        }
    }
}
