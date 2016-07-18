//
//  AppDelegate.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// AppDelegate Class;
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    class var sharedDelegate: AppDelegate {
        return UIApplication.sharedApplication().delegate as AppDelegate
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Status Bar;
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        // Navigation Bar;
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navi_background"), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20)!]
        
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 18)!], forState: UIControlState.Normal)
        
        // Tab Bar;
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        // Location;
        LocationClient.sharedClient.startUpdatingLocation()
        
        // Authorized;
        if (Account.me.isAuthorized()) {
            didAccountLogin()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Facebook;
        FBAppEvents.activateApp()
        FBAppCall.handleDidBecomeActiveWithSession(FBSession.activeSession())
    }

    func applicationWillTerminate(application: UIApplication) {
        // Facebook;
        FBSession.activeSession().close()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        let facebook = "fb1488311911384013"
        let google = "com.happycakesdesign.HairSnaps"
        let pinterest = "com.happycakesdesign.HairSnaps"
        
        let scheme = url.scheme
        
        if (scheme?.hasPrefix(facebook) == true) {
            return FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication, withSession: FBSession.activeSession())
        } else if (scheme?.hasPrefix(google.lowercaseString) == true) {
            return GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
        } else if (scheme?.hasPrefix(google.lowercaseString) == true) {
            return true
        }
        
        return true
    }
    
    func didAccountLogin() {
        // First Time;
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "first")
        userDefaults.synchronize()
        
        // Root Controller;
        let storyboard: UIStoryboard! = window?.rootViewController?.storyboard
        let viewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as TabBarController
        window?.rootViewController = viewController
    }
    
    func didAccountLogout() {
        // Root Controller;
        let storyboard: UIStoryboard! = window?.rootViewController?.storyboard
        let viewController = storyboard.instantiateViewControllerWithIdentifier("SignNavigationController") as SignNavigationController
        window?.rootViewController = viewController
    }
}

