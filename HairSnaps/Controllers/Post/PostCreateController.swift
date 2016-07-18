//
//  PostCreateController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// PostCreateController Class;
class PostCreateController: UITableViewController, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var side1Button: UIButton!
    @IBOutlet weak var side2Button: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var salonText: UITextField!
    @IBOutlet weak var stylistText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var detailText: UITextField!
    
    var selectedButton: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        let postController = navigationController as PostNavigationController
        
        if (postController.frontImage != nil) {
            frontButton.setImage(postController.frontImage, forState: UIControlState.Normal)
        }
        
        if (postController.side1Image != nil) {
            side1Button.setImage(postController.side1Image, forState: UIControlState.Normal)
        }
        
        if (postController.side2Image != nil) {
            side2Button.setImage(postController.side2Image, forState: UIControlState.Normal)
        }
        
        if (postController.backImage != nil) {
            backButton.setImage(postController.backImage, forState: UIControlState.Normal)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Load;
        let postController = navigationController as PostNavigationController
        
        // Salon;
        if (postController.salon != nil) {
            let salon = postController.salon
            salonText.text = salon.name
        } else {
            salonText.text = ""
        }
        
        // Stylist;
        if (postController.stylist != nil) {
            let stylist = postController.stylist
            stylistText.text = stylist.username
        } else {
            stylistText.text = ""
        }
        
        // Price;
        if (postController.price != nil) {
            let price = postController.price
            priceText.text = NSString(format: "$%d - $%d", price.min_price, price.max_price)
        } else if (postController.ownPrice != nil) {
            priceText.text = NSString(format: "$%@", postController.ownPrice)
        } else {
            priceText.text = ""
        }
        
        // Detail;
        if (postController.detail != nil) {
            detailText.text = postController.detail
        } else {
            detailText.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        switch (buttonIndex) {
        case 1:     // Camera;
            let pickerController: UIImagePickerController! = UIImagePickerController()
            pickerController.delegate = self
            pickerController.editing = false
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
            break
            
        case 2:     // Choose Photo;
            let pickerController: UIImagePickerController! = UIImagePickerController()
            pickerController.delegate = self
            pickerController.editing = false
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(pickerController, animated: true, completion: nil)
            break
            
        case 3:     // Delete Photo;
            deletePhoto()
            break
            
        default:
            break
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        let pickerController = navigationController as UIImagePickerController
        
        if (pickerController.sourceType != UIImagePickerControllerSourceType.Camera) {
            // Status Bar;
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.choosePhoto(image)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func chooseButton(index: Int) {
        let postController = navigationController as PostNavigationController
        var image: UIImage! = nil
        
        // Selected;
        selectedButton = index
        
        // Image;
        switch (selectedButton) {
        case 1:
            image = postController.frontImage
            break
            
        case 2:
            image = postController.side1Image
            break
            
        case 3:
            image = postController.side2Image
            break
            
        case 4:
            image = postController.backImage
            break
            
        default:
            break
        }
        
        // Action Sheet;
        if (image != nil) {
            UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Choose Photo", "Delete Photo").showInView(view)
        } else {
            UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Choose Photo").showInView(view)
        }
    }
    
    func choosePhoto(image: UIImage!) {
        let postController = navigationController as PostNavigationController
        
        // Image;
        switch (selectedButton) {
        case 1:
            postController.frontImage = image
            frontButton.setImage(image, forState: UIControlState.Normal)
            break
            
        case 2:
            postController.side1Image = image
            side1Button.setImage(image, forState: UIControlState.Normal)
            break
            
        case 3:
            postController.side2Image = image
            side2Button.setImage(image, forState: UIControlState.Normal)
            break
            
        case 4:
            postController.backImage = image
            backButton.setImage(image, forState: UIControlState.Normal)
            break
            
        default:
            break
        }
    }
    
    func deletePhoto() {
        let postController = navigationController as PostNavigationController
        
        // Image;
        switch (selectedButton) {
        case 1:
            postController.frontImage = nil
            frontButton.setImage(UIImage(named: "post_photo_front"), forState: UIControlState.Normal)
            break
            
        case 2:
            postController.side1Image = nil
            side1Button.setImage(UIImage(named: "post_photo_side1"), forState: UIControlState.Normal)
            break
            
        case 3:
            postController.side2Image = nil
            side2Button.setImage(UIImage(named: "post_photo_side2"), forState: UIControlState.Normal)
            break
            
        case 4:
            postController.backImage = nil
            backButton.setImage(UIImage(named: "post_photo_back"), forState: UIControlState.Normal)
            break
            
        default:
            break
        }
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onBtnPost(sender: AnyObject) {
        let postController = navigationController as PostNavigationController
        
        if (postController.frontImage == nil) {
            AZNotification.showNotificationWithTitle("Please add front photo before posting.", controller: self, notificationType: AZNotificationType.Error)
            return
        }
        
        if (postController.salon == nil) {
            AZNotification.showNotificationWithTitle("Please enter salon name before posting.", controller: self, notificationType: AZNotificationType.Error)
            return
        }
        
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Post;
        APIClient.sharedClient.postSnaps(postController.frontImage, side1Image: postController.backImage, side2Image: postController.side2Image, backImage: postController.backImage, salon: postController.salon, stylist: postController.stylist, price: postController.price, ownPrice: postController.ownPrice, detail: postController.detail, caption: "", completion: { (post, successed) -> Void in
            // Hide;
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            if (!successed) {
                // Notification;
                AZNotification.showNotificationWithTitle("Please enter salon name before posting.", controller: self, notificationType: AZNotificationType.Error)
            } else {
                // Notification;
                AZNotification.showNotificationWithTitle("Post created successfully.", controller: self, notificationType: AZNotificationType.Success)
                
                // Notification;
                let defaultCenter = NSNotificationCenter.defaultCenter()
                defaultCenter.postNotificationName("didCreatePost", object: post)
                
                // Dismiss;
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }
    
    @IBAction func onBtnFront(sender: AnyObject) {
        chooseButton(1)
    }
    
    @IBAction func onBtnSide1(sender: AnyObject) {
        chooseButton(2)
    }
    
    @IBAction func onBtnSide2(sender: AnyObject) {
        chooseButton(3)
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        chooseButton(4)
    }
}
