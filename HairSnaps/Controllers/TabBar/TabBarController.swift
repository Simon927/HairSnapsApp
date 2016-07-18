//
//  TabBarController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// TabBarController Class;
class TabBarController: UITabBarController, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TabBarDelegate {

    var customizedTabBar: TabBar!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab Bar;
        customizedTabBar = NSBundle.mainBundle().loadNibNamed("TabBar", owner: nil, options: nil)[0] as TabBar
        customizedTabBar.delegate = self
        customizedTabBar.frame = tabBar.bounds
        customizedTabBar.selectedIndex = 0
        tabBar.addSubview(customizedTabBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        switch (buttonIndex) {
        case 1:
            let pickerController: UIImagePickerController! = UIImagePickerController()
            pickerController.delegate = self
            pickerController.editing = false
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
            break
            
        case 2:
            let pickerController: UIImagePickerController! = UIImagePickerController()
            pickerController.delegate = self
            pickerController.editing = false
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(pickerController, animated: true, completion: nil)
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
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("PostNavigationController") as PostNavigationController
            viewController.delegate = viewController
            viewController.frontImage = image
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tabBar(tabBar: TabBar, didSelectIndex index: Int) {
        if (index != self.selectedIndex) {
            self.selectedIndex = index;
        } else if (selectedViewController?.isKindOfClass(UINavigationController) != nil) {
            let controller = selectedViewController as UINavigationController!
            controller.popToRootViewControllerAnimated(true)
        }
    }
    
    func tabBarDidCamera(tabBar: TabBar) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("PostNavigationController") as PostNavigationController
        viewController.delegate = viewController
        self.presentViewController(viewController, animated: true, completion: nil)
        
/*      let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take Photo", "Choose Existing")
        actionSheet.showInView(self.view) */
    }
}
