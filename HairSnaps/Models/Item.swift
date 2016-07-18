//
//  Item.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Item Class;
class Item: NSObject {
 
    var id: Int!
    var name: String!
    var username: String!
    var firstName: String!
    var lastName: String!
    var photo: String!
    var does_user_follow: Bool!
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        name = attributes.stringForKey("name")
        username = attributes.stringForKey("username")
        firstName = attributes.stringForKey("firstName")
        lastName = attributes.stringForKey("lastName")
        photo = attributes.stringForKey("photo")
        does_user_follow = attributes.boolForKey("does_user_follow")
    }

}
