//
//  Stylist.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Stylist Class;
class Stylist: NSObject {
    
    var id: Int!
    var name: String!
    var user_id: Int!
    var username: String!
    var accepted: String!
    var created_at: String!
    var updated_at: String!
    
    class func stylist(attributes: NSDictionary!) -> Stylist? {
        if (attributes == nil) {
            return nil
        }
        
        return Stylist(attributes: attributes)
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        name = attributes.stringForKey("name")
        user_id = attributes.integerForKey("user_id")
        username = attributes.stringForKey("username")
        accepted = attributes.stringForKey("accepted")
        created_at = attributes.stringForKey("created_at")
        updated_at = attributes.stringForKey("updated_at")
    }
}
