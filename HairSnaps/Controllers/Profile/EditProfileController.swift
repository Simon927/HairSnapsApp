//
//  EditProfileController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// EditProfileController Class;
class EditProfileController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var lastText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var ownerSwitch: UISwitch!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Profile;
        firstText.text = Account.me.firstName
        lastText.text = Account.me.lastName
        cityText.text = Account.me.city
        stateText.text = Account.me.state
        bioText.text = Account.me.bio
        ownerSwitch.on = Account.me.stylisted
        emailLabel.text = Account.me.email
        phoneLabel.text = Account.me.phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnSave(sender: AnyObject) {
        
    }
}
