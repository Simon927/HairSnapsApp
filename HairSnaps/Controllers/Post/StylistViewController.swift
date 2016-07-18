//
//  StylistViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// StylistViewController Class;
class StylistViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var stylistText: UITextField!
    @IBOutlet weak var stylistView: UITableView!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    var stylists: NSMutableArray! = NSMutableArray()
    
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
        defaultCenter.addObserver(
            self,
            selector: Selector("textFieldChanged:"),
            name: UITextFieldTextDidChangeNotification,
            object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Notification;
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.removeObserver(self,
            name: UIKeyboardWillShowNotification,
            object: nil)
        defaultCenter.removeObserver(self,
            name: UIKeyboardWillHideNotification,
            object: nil)
        defaultCenter.removeObserver(self,
            name: UITextFieldTextDidChangeNotification,
            object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (stylists.count > 0) {
            return stylists.count + 1
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (stylists.count > 0) {
            if (indexPath.row == 0) {
                var cell = tableView.dequeueReusableCellWithIdentifier("CreateCell", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel?.text = NSString(format: "Create \"%@\"", stylistText.text != nil ? stylistText.text : "")
                return cell
            } else {
                // User;
                let suggestion = stylists[indexPath.row - 1] as User
                
                // Cell;
                var cell = tableView.dequeueReusableCellWithIdentifier("StylistCell", forIndexPath: indexPath) as UITableViewCell
                cell.imageView?.sd_setImageWithURL(NSURL(string: suggestion.photo), placeholderImage: UIImage(named: "profile_placholder"))
                cell.textLabel?.text = suggestion.username
                cell.detailTextLabel?.text = suggestion.name
                return cell
            }
        }
        
        return nil as UITableViewCell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (stylists.count > 0) {
            // Set
            let postController = self.navigationController as PostNavigationController
            
            // Stylist;
            postController.stylist = stylists[indexPath.row - 1] as User
            
            // Pop;
            postController.popToRootViewControllerAnimated(true)
        }
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
    
    func textFieldChanged(sender: AnyObject) {
        let textField = sender.object as UITextField
        
        if (textField == stylistText) {
            loadStylists()
        }
    }
    
    func loadStylists() {
        // Places;
        APIClient.sharedClient.suggestions(stylistText.text, completion: { (suggestions) -> Void in
            // Remove;
            self.stylists.removeAllObjects()
            
            // Add;
            self.stylists.addObjectsFromArray(suggestions)
            
            // Reload;
            self.stylistView.reloadData()
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        
    }
}
