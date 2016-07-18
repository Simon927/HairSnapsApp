//
//  ChangePasswordController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ChangePasswordController Class;
class ChangePasswordController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var oldText: UITextField!
    @IBOutlet weak var newText: UITextField!
    @IBOutlet weak var confirmText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkBlankField() -> Bool {
        let fields = [oldText, newText, confirmText]
        
        for field in fields {
            if (field.text == "") {
                AZNotification.showNotificationWithTitle("All fields are required.", controller: self, notificationType: AZNotificationType.Error)
                return false
            }
        }
        
        return true
    }
    
    func checkPassword() -> Bool {
        if (newText.text.utf16Count < 8) {
            AZNotification.showNotificationWithTitle("Password must be 8 characters long.", controller: self, notificationType: AZNotificationType.Error)
            return false;
        }
        
        return true;
    }
    
    func checkConfirmPassword() -> Bool {
        if (newText.text != confirmText.text) {
            AZNotification.showNotificationWithTitle("Password doesn't match.", controller: self, notificationType: AZNotificationType.Error)
            return false;
        }
        
        return true;
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        // Editing;
        view.endEditing(true)
        
        // Blank Fields;
        if (!checkBlankField()) {
            return
        }
        
        // Password;
        if (!checkPassword()) {
            return
        }
        
        // Confirm Password;
        if (!checkConfirmPassword()) {
            return
        }
        
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Change Password;
    }
}
