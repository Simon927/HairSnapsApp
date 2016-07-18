//
//  Account.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Constants
let kAccountId = "id"

let kAccountUsername = "username"
let kAccountEmail = "email"
let kAccountPassword = "password"

let kAccountName = "name"
let kAccountFirstName = "firstname"
let kAccountLastName = "lastname"

let kAccountPhoto = "photo"

let kAccountPhone = "phone"
let kAccountPrivatePhone = "privatePhone"
let kAccountPublicPhone = "publicPhone"

let kAccountAddress = "address"
let kAccountCity = "city"
let kAccountState = "state"

let kAccountBio = "bio"

let kAccountStylist = "stylist"
let kAccountActivites = "activities"
let kAccountStylistSalonName = "stylistSalonName"

let kAccountPosts = "posts"
let kAccountFollowings = "followings"
let kAccountFollowers = "followers"
let kAccountLikes = "likes"
let kAccountTags = "tags"

let kAccountAuthentications = "authentications"
let kAccountAuthenticationToken = "authenticationToken"
let kAccountDeviceToken = "deviceToken"

let kAccountCreatedAt = "createdAt"
let kAccountUpdatedAt = "updatedAt"

// Account Class;
class Account: User {
    
    override var id: Int! {
        set {
            setInteger(newValue, forKey: kAccountId)
        }
        
        get {
            return integerForKey(kAccountId)
        }
    }
    
    override var username: String! {
        set {
            setString(newValue, forKey: kAccountUsername)
        }
        
        get {
            return stringForKey(kAccountUsername)
        }
    }
    
    override var email: String! {
        set {
            setString(newValue, forKey: kAccountEmail)
        }
        
        get {
            return stringForKey(kAccountEmail)
        }
    }
    
    override var name: String! {
        set {
            setString(newValue, forKey: kAccountName)
        }
        
        get {
            return stringForKey(kAccountName)
        }
    }
    
    override var firstName: String! {
        set {
            setString(newValue, forKey: kAccountFirstName)
        }
        
        get {
            return stringForKey(kAccountFirstName)
        }
    }
    
    override var lastName: String! {
        set {
            setString(newValue, forKey: kAccountLastName)
        }
        
        get {
            return stringForKey(kAccountLastName)
        }
    }

    override var photo: String! {
        set {
            setString(newValue, forKey: kAccountPhoto)
        }
        
        get {
            return stringForKey(kAccountPhoto)
        }
    }
    
    override var phone: String! {
        set {
            setString(newValue, forKey: kAccountPhone)
        }
        
        get {
            return stringForKey(kAccountPhone)
        }
    }
    
    override var privatePhone: String! {
        set {
            setString(newValue, forKey: kAccountPrivatePhone)
        }
        
        get {
            return stringForKey(kAccountPrivatePhone)
        }
    }
    
    override var publicPhone: String! {
        set {
            setString(newValue, forKey: kAccountPublicPhone)
        }
        
        get {
            return stringForKey(kAccountPublicPhone)
        }
    }
    
    override var address: String! {
        set {
            setString(newValue, forKey: kAccountAddress)
        }
        
        get {
            return stringForKey(kAccountAddress)
        }
    }
    
    override var city: String! {
        set {
            setString(newValue, forKey: kAccountCity)
        }
        
        get {
            return stringForKey(kAccountCity)
        }
    }
    
    override var state: String! {
        set {
            setString(newValue, forKey: kAccountState)
        }
        
        get {
            return stringForKey(kAccountState)
        }
    }
    
    override var bio: String! {
        set {
            setString(newValue, forKey: kAccountBio)
        }
        
        get {
            return stringForKey(kAccountBio)
        }
    }
    
    override var stylisted: Bool! {
        set {
            setBool(newValue, forKey: kAccountStylist)
        }
        
        get {
            return boolForKey(kAccountStylist)
        }
    }
    
    override var numberOfActivities: Int! {
        set {
            setInteger(newValue, forKey: kAccountActivites)
        }
        
        get {
            return integerForKey(kAccountActivites)
        }
    }
    
    override var stylistSalonName: String! {
        set {
            setString(newValue, forKey: kAccountStylistSalonName)
        }

        get {
            return stringForKey(kAccountStylistSalonName)
        }
    }

    override var numberOfPosts: Int! {
        set {
            setInteger(newValue, forKey: kAccountPosts)
        }
        
        get {
            return integerForKey(kAccountPosts)
        }
    }
    
    override var numberOfFollowings: Int! {
        set {
            setInteger(newValue, forKey: kAccountFollowings)
        }
        
        get {
            return integerForKey(kAccountFollowings)
        }
    }
    
    override var numberOfFollowers: Int! {
        set {
            setInteger(newValue, forKey: kAccountFollowers)
        }
        
        get {
            return integerForKey(kAccountFollowers)
        }
    }
    
    override var numberOfLikes: Int! {
        set {
            setInteger(newValue, forKey: kAccountLikes)
        }
        
        get {
            return integerForKey(kAccountLikes)
        }
    }
    
    override var numberOfTags: Int! {
        set {
            setInteger(newValue, forKey: kAccountTags)
        }
        
        get {
            return integerForKey(kAccountTags)
        }
    }
    
/*  override var authentications: NSArray! {
        set {
//          setString(authentications, forKey: kAccountAuthentications)
        }
        
        get {
            return authentications
        }
    } */
    
    override var authenticationToken: String! {
        set {
            setString(newValue, forKey: kAccountAuthenticationToken)
        }
        
        get {
            return stringForKey(kAccountAuthenticationToken)
        }
    }
    
    override var deviceToken: String! {
        set {
            setString(newValue, forKey: kAccountDeviceToken)
        }
        
        get {
            return stringForKey(kAccountDeviceToken)
        }
    }
    
    override var createdAt: String! {
        set {
            setString(newValue, forKey: kAccountCreatedAt)
        }
        
        get {
            return stringForKey(kAccountCreatedAt)
        }
    }
    
    override var updatedAt: String! {
        set {
            setString(newValue, forKey: kAccountUpdatedAt)
        }
        
        get {
            return stringForKey(kAccountUpdatedAt)
        }
    }
    
    class var me: Account {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var me: Account? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.me = Account()
        }
        return Static.me!
    }
    
    func isAuthorized() -> Bool {
        return (id > 0)
    }
    
    func logout() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(kAccountId)
        userDefaults.synchronize()
    }
    
    func setString(value: String?, forKey: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: forKey)
        userDefaults.synchronize()
    }
    
    func setInteger(value: Int, forKey: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(value, forKey: forKey)
        userDefaults.synchronize()
    }
    
    func setBool(value: Bool, forKey: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(value, forKey: forKey)
        userDefaults.synchronize()
    }
    
    func stringForKey(defaultName: String) -> String? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let value = userDefaults.objectForKey(defaultName) as String?
        return value != nil ? value : ""
    }
    
    func integerForKey(defaultName: String) -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.integerForKey(defaultName)
    }
    
    func boolForKey(defaultName: String) -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.boolForKey(defaultName)
    }
}
