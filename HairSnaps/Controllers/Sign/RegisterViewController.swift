//
//  RegisterViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// RegisterViewController Class;
class RegisterViewController: UIViewController, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    var photo: UIImage! = nil
    
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
        
        // Photo;
        photoButton.layer.cornerRadius = photoButton.bounds.width / 2
        photoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
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
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if (buttonIndex == 1) {
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                let pickerController: UIImagePickerController! = UIImagePickerController()
                pickerController.delegate = self
                pickerController.editing = true
                pickerController.sourceType = UIImagePickerControllerSourceType.Camera
                pickerController.cameraDevice = UIImagePickerControllerCameraDevice.Front
                self.presentViewController(pickerController, animated: true, completion: nil)
            }
        } else if (buttonIndex == 2) {
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
                let pickerController: UIImagePickerController! = UIImagePickerController()
                pickerController.delegate = self
                pickerController.editing = true
                pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                pickerController.navigationBar.barTintColor = UIColor(red: 98.0 / 255.0, green: 205.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
                pickerController.navigationBar.tintColor = UIColor.whiteColor()
                self.presentViewController(pickerController, animated: true, completion: nil)
            }
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        // Status Bar;
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        // Dismiss;
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            // Set;
            self.photo = image
            
            // Photo Button;
            self.photoButton.setImage(image, forState: UIControlState.Normal)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField == phoneText) {
            var newString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            var components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            var decimalString = "".join(components) as NSString
            var length = decimalString.length
            var hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (49 as unichar)
            
            if (length == 0 || (length > 10 && !hasLeadingOne) || length > 11) {
                var newLength = (textField.text as NSString).length + (string as NSString).length - range.length as Int
                return (newLength > 10) ? false : true
            }
            
            var index = 0 as Int
            var formattedString = NSMutableString()
            
            if (hasLeadingOne) {
                formattedString.appendString("1")
                index += 1
            }
            
            if ((length - index) > 3) {
                var areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            
            if (length - index > 3) {
                var prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            var remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == usernameText) {
            passwordText.becomeFirstResponder()
        } else if (textField == passwordText) {
            emailText.becomeFirstResponder()
        } else if (textField == emailText) {
            phoneText.becomeFirstResponder()
        } else if (textField == phoneText) {
            phoneText.resignFirstResponder()
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
        let fields = [usernameText, passwordText, emailText, phoneText]
        
        for field in fields {
            if (field.text == "") {
                AZNotification.showNotificationWithTitle("All fields are required.", controller: self, notificationType: AZNotificationType.Error)
                return false
            }
        }
        
        return true
    }
    
    func checkPassword() -> Bool {
        if (passwordText.text.utf16Count < 8) {
            AZNotification.showNotificationWithTitle("Password must be 8 characters long.", controller: self, notificationType: AZNotificationType.Error)
            return false;
        }
        
        return true;
    }
    
    func checkEmail() -> Bool {
        var filterString: String! = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var emailTest: NSPredicate! = NSPredicate(format: "SELF MATCHES %@", filterString)
        if (emailTest.evaluateWithObject(emailText.text) == false) {
            AZNotification.showNotificationWithTitle("Email address is not correct.", controller: self, notificationType: AZNotificationType.Error)
            return false;
        }
        
        return true;
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onBtnPhoto(sender: AnyObject) {
        UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Choose photo").showInView(view)
    }
    
    @IBAction func onBtnRegister(sender: AnyObject) {
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

        // Email;
        if (!checkEmail()) {
            return
        }
        
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Register;
        APIClient.sharedClient.register(usernameText.text, password: passwordText.text, email: emailText.text, phone: phoneText.text, photo: photo, completion: { (successed: Bool, error: String!) -> Void in
            // Hide;
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if (!successed) {
                AZNotification.showNotificationWithTitle(error, controller: self, notificationType: AZNotificationType.Error)
            } else {
                AppDelegate.sharedDelegate.didAccountLogin()
            }
        })
    }
}
