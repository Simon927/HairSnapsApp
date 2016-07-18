//
//  WalkthroughPopupController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// WalkthroughPopupDelegate Protocol;
protocol WalkthroughPopupDelegate: NSObjectProtocol {
    func didClose(controller: WalkthroughPopupController!)
    func didLogin(controller: WalkthroughPopupController!)
    func didRegister(controller: WalkthroughPopupController!)
}

// WalkthroughPopupController Class;
class WalkthroughPopupController: UIViewController {

    var delegate: WalkthroughPopupDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showController(controller: UIViewController!) {
        // Window;
        let window: UIWindow! = UIApplication.sharedApplication().keyWindow
        window?.addSubview(view)

        // Controller;
        controller.addChildViewController(self)

        // Animation;
        view.alpha = 0.0
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.view.alpha = 1.0
        }, completion: { (finished: Bool) -> Void in
            
        })
    }
    
    func hideController() {
        // Animation;
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.view.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        if (delegate.respondsToSelector("didClose:")) {
            delegate.didClose(self)
        }
    }
    
    @IBAction func onBtnLogin(sender: AnyObject) {
        if (delegate.respondsToSelector("didLogin:")) {
            delegate.didLogin(self)
        }
    }
    
    @IBAction func onBtnRegister(sender: AnyObject) {
        if (delegate.respondsToSelector("didRegister:")) {
            delegate.didRegister(self)
        }
    }
}
