//
//  ForgotViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ForgotViewController Class;
class ForgotViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == emailText) {
            emailText.resignFirstResponder()
        }
        
        return true
    }

    @IBAction func onBtnClose(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onBtnSubmit(sender: AnyObject) {
        APIClient.sharedClient.forgotPassword(emailText.text, completion: { (successed) -> Void in
            if (successed) {
                
            } else {
                
            }
        })
    }
}
