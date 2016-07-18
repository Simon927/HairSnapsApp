//
//  LoginViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// LoginViewController Class;
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Notification;
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(
            self,
            selector: "willShowKeyBoard:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        defaultCenter.addObserver(
            self,
            selector: "willHideKeyBoard:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Notification;
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == emailText) {
            passwordText.becomeFirstResponder()
        } else if (textField == passwordText) {
            passwordText.resignFirstResponder()
        }
        
        return true
    }
    
    func willShowKeyBoard(notification: NSNotification) {
        let userInfo: NSDictionary! = notification.userInfo
        let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        let frame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        // Animation;
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.bottomSpace.constant = frame.height
            self.view.layoutIfNeeded()
        })
    }
    
    func willHideKeyBoard(notification: NSNotification) {
        let userInfo: NSDictionary! = notification.userInfo
        let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        
        // Animation;
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.bottomSpace.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func checkBlankField() -> Bool {
        let fields = [emailText, passwordText]
        
        for field in fields {
            if (field.text == "") {
                AZNotification.showNotificationWithTitle("Please provide valid username/password.", controller: self, notificationType: AZNotificationType.Error)
                return false
            }
        }
        
        return true
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnLogin(sender: AnyObject) {
        // Editing;
        view.endEditing(true)
        
        // Blank Fields;
        if (!checkBlankField()) {
            return
        }
        
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        APIClient.sharedClient.login(emailText.text, password: passwordText.text, completion: { (successed: Bool) -> Void in
            // Hide;
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if (!successed) {
                AZNotification.showNotificationWithTitle("Please provide valid username/password.", controller: self, notificationType: AZNotificationType.Error)
            } else {
                AppDelegate.sharedDelegate.didAccountLogin()
            }
        })
    }
}
