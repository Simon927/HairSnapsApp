//
//  SignViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import Social

// --- Defines ---;
// Twitter Client;
let kTwitterAPIKey = "dISpuwaUSecJWxKXJFRZkzF4s"
let kTwitterAPISecret = "HY3zKg4AdqzdoBSXaLZuFiyF5On8VjLBh3Y9eIcQuUlXpnfQTx"

// Google Client;
let kGoogleClientID = "785935775067-pmq5tli38ehc9q7lv40h9vas4f2gkdm6.apps.googleusercontent.com"

// SignViewController Class;
class SignViewController: UIViewController, GPPSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        loginFromGoogle()
    }
    
    func didDisconnectWithError(error: NSError!) {
        didLoginFailed()
    }
    
    func loginFromFacebook() {
        let accessToken = FBSession.activeSession().accessTokenData.accessToken
        
        // Login;
        APIClient.sharedClient.loginByFacebook(accessToken, completion: { (successed: Bool) -> Void in
            if (successed) {
                self.didLoginSuccessed()
            } else {
                self.didLoginFailed()
            }
        })
    }
    
    func loginFromGoogle() {
        let accessToken = GPPSignIn.sharedInstance().authentication.accessToken
        
        // Login;
        APIClient.sharedClient.loginByGoogle(accessToken, completion: { (successed: Bool) -> Void in
            if (successed) {
                self.didLoginSuccessed()
            } else {
                self.didLoginFailed()
            }
        })
    }
    
    func loginFromTwitter(oAuthToken: String!, oAuthTokenSecret: String!) {
        // Login;
        APIClient.sharedClient.loginByTwitter(oAuthToken, tokenSecret: oAuthTokenSecret, completion: { (successed: Bool) -> Void in
            if (successed) {
                self.didLoginSuccessed()
            } else {
                self.didLoginFailed()
            }
        })
    }
    
    func didLoginSuccessed() {
        // Hide;
        MBProgressHUD.hideHUDForView(view, animated: true)
        
        // UI;
        AppDelegate.sharedDelegate.didAccountLogin()
    }
    
    func didLoginFailed() {
        // Hide;
        MBProgressHUD.hideHUDForView(view, animated: true)
    }

    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onBtnFacebook(sender: AnyObject) {
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        // Session;
        if (!FBSession.activeSession().isOpen) {
            if (FBSession.activeSession().state != FBSessionState.Created) {
                var session: FBSession = FBSession(permissions: ["email", "public_profile", "user_friends"])
                FBSession.setActiveSession(session)
            }
            
            FBSession.activeSession().openWithCompletionHandler({ (session: FBSession!, status: FBSessionState, error: NSError!) -> Void in
                if (error != nil) {
                    self.didLoginFailed()
                } else {
                    self.loginFromFacebook()
                }
                return
            })
        } else {
            loginFromFacebook()
        }
    }
    
    @IBAction func onBtnTwitter(sender: AnyObject) {
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        let twitter = STTwitterAPI(OAuthConsumerKey: kTwitterAPIKey, consumerSecret: kTwitterAPISecret)
        twitter.postReverseOAuthTokenRequest( { (authenticationHeader: String!) -> Void in
            let twitterAPIIOS = STTwitterAPI.twitterAPIOSWithFirstAccount()
            twitterAPIIOS.verifyCredentialsWithSuccessBlock({ (username: String!) -> Void in
                twitterAPIIOS.postReverseAuthAccessTokenWithAuthenticationHeader(authenticationHeader, successBlock: { (oAuthToken: String!, oAuthTokenSecret: String!, userID: String!, screenName: String!) -> Void in
                    self.loginFromTwitter(oAuthToken, oAuthTokenSecret: oAuthTokenSecret)
                }, errorBlock: { (error: NSError!) -> Void in
                    self.didLoginFailed()
                })
            }, errorBlock: { (error: NSError!) -> Void in
                self.didLoginFailed()
            })
        }, errorBlock: { (error: NSError!) -> Void in
            self.didLoginFailed()
        })
    }
    
    @IBAction func onBtnGoogle(sender: AnyObject) {
        // Show;
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        let signIn = GPPSignIn.sharedInstance()
        signIn.delegate = self
        signIn.clientID = kGoogleClientID
        signIn.scopes = [kGTLAuthScopePlusLogin]
        signIn.shouldFetchGooglePlusUser = true
        
        if (signIn.authentication == nil) {
            signIn.authenticate()
        } else {
            loginFromGoogle()
        }
    }
    
    @IBAction func onBtnMail(sender: AnyObject) {
        if (navigationItem.title == "LOG IN") {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as LoginViewController
            navigationController?.pushViewController(viewController, animated: true)
        } else if (navigationItem.title == "SIGN UP") {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") as RegisterViewController
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
