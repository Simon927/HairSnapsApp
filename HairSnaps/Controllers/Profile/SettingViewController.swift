//
//  SettingViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import MessageUI

// --- Defines ---;
// SettingViewController Class;
class SettingViewController: UITableViewController, UIActionSheetDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 4:     // Support;
                if (MFMailComposeViewController.canSendMail()) {
                    let mailController = MFMailComposeViewController()
                    mailController.delegate = self
                    mailController.mailComposeDelegate = self
                    mailController.setSubject("HairSnaps Support")
                    mailController.setToRecipients(["support@hairsnaps.com"])
                    presentViewController(mailController, animated: true, completion: { () -> Void in
                        // Status Bar;
                        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
                    })
                } else {
                    // Alert;
                    let alertView = UIAlertView(title: "Configure Email", message: "Device is not configured to send emails. Please configure Mail application.", delegate: self, cancelButtonTitle: "Okay") as UIAlertView
                    alertView.show()
                }
                break
                
            default:
                break
            }
            break
            
        case 1:
            switch (indexPath.row) {
            case 0:     // Log Out;
                let title = "You are logged in as " + Account.me.username
                let actionSheet = UIActionSheet(title: title, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Log Out")
                actionSheet.showInView(self.view)
                break
                
            default:
                break
            }
            break
            
        default:
            break
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        // Status Bar;
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        // Status Bar;
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        // Deselect
        let indexPath: NSIndexPath! = tableView.indexPathForSelectedRow()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        // Log Out;
        switch (buttonIndex) {
        case 1:
            // Show;
            MBProgressHUD.showHUDAddedTo(view, animated: true)
            
            // Logout;
            APIClient.sharedClient.logout({ (successed) -> Void in
                // Hide;
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                // Log out;
                if (!successed) {
                    AZNotification.showNotificationWithTitle("Failed to log out.", controller: self, notificationType: AZNotificationType.Error)
                } else {
                    AppDelegate.sharedDelegate.didAccountLogout()
                }
            })
            break
            
        default:
            break;
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        // Deselect
        let indexPath: NSIndexPath! = tableView.indexPathForSelectedRow()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
