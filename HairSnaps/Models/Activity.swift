//
//  Activity.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Activity Class;
class Activity: NSObject {
    
    var id: Int!
    var user: User!
    var message: String!
    var created_at: String!
    var updated_at: String!
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        user = User(attributes: attributes.dictionaryForKey("user"))
        message = attributes.stringForKey("message")
        created_at = attributes.stringForKey("created_at")
        updated_at = attributes.stringForKey("updated_at")
    }
}
