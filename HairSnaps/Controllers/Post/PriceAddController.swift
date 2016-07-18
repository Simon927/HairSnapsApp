//
//  PriceAddController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PriceViewController Class;
class PriceAddController: UIViewController {

    @IBOutlet weak var priceText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Edit;
        priceText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        // Set
        let postController = self.navigationController as PostNavigationController
        
        // Price;
        postController.price = nil
        
        // Own Price;
        postController.ownPrice = priceText.text
        
        // Pop;
        postController.popToRootViewControllerAnimated(true)
    }
}
