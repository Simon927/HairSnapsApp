//
//  User.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// User Class;
@objc(User)
class User: NSObject {

    var id: Int!
    
    var username: String!
    var email: String!

    var name: String!
    var firstName: String!
    var lastName: String!
    
    var photo: String!

    var phone: String!
    var privatePhone: String!
    var publicPhone: String!

    var address: String!
    var city: String!
    var state: String!
    
    var bio: String!
 
    var stylisted: Bool!
    var numberOfActivities: Int!
    var stylistSalonName: String!
    
    var followed: Int!
    
    var numberOfPosts: Int!
    var numberOfFollowings: Int!
    var numberOfFollowers: Int!
    var numberOfLikes: Int!
    var numberOfTags: Int!
    
    var authentications: NSArray!
    var authenticationToken: String!
    var deviceToken: String!
    
    var createdAt: String!
    var updatedAt: String!
    
    override init() {
        super.init()
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        setAttributes(attributes)
    }
    
    func setAttributes(attributes: NSDictionary!) {
        id = attributes.integerForKey("id")
        
        username = attributes.stringForKey("username")
        email = attributes.stringForKey("email")
        
        name = attributes.stringForKey("user_name")
        firstName = attributes.stringForKey("firstname")
        lastName = attributes.stringForKey("lastname")
        
        photo = attributes.stringForKey("photo")
        
        phone = attributes.stringForKey("userid")
        privatePhone = attributes.stringForKey("private_phone_number")
        publicPhone = attributes.stringForKey("public_phone_number")
        
        address = attributes.stringForKey("address")
        city = attributes.stringForKey("city")
        state = attributes.stringForKey("state")
        
        bio = attributes.stringForKey("bio")
        
        stylisted = attributes.boolForKey("is_stylist")
        numberOfActivities = attributes.integerForKey("new_activity_count")
        stylistSalonName = attributes.stringForKey("stylist_salon_name")

        followed = attributes.integerForKey("does_user_follow")
        
        numberOfPosts = attributes.integerForKey("posts_count")
        numberOfFollowings = attributes.integerForKey("following_count")
        numberOfFollowers = attributes.integerForKey("followers_count")
        numberOfLikes = attributes.integerForKey("my_likes_count")
        numberOfTags = attributes.integerForKey("tags_count")
        
//      authentications = attributes.stringForKey("authentications")
        authenticationToken = attributes.stringForKey("authentication_token")
        deviceToken = attributes.stringForKey("device_token")
        
        createdAt = attributes.stringForKey("created_at")
        updatedAt = attributes.stringForKey("updated_at")
    }
}
