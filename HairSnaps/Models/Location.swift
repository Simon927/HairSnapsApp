//
//  Location.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Location Class;
class Location: NSObject {
    
    var id: Int!
    var latitude: Double!
    var longitude: Double!
    var name: String!
    var place_id: Int!
    var addressable_id: Int!
    var addressable_type: String!
    var city: String!
    var state: String!
    var created_at: String!
    var updated_at: String!
    
    class func location(attributes: NSDictionary!) -> Location? {
        if (attributes == nil) {
            return nil
        }
        
        return Location(attributes: attributes)
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        latitude = attributes.doubleForKey("latitude")
        longitude = attributes.doubleForKey("longitude")
        name = attributes.stringForKey("name")
        place_id = attributes.integerForKey("place_id")
        addressable_id = attributes.integerForKey("addressable_id")
        addressable_type = attributes.stringForKey("addressable_type")
        city = attributes.stringForKey("city")
        state = attributes.stringForKey("state")
        created_at = attributes.stringForKey("created_at")
        updated_at = attributes.stringForKey("updated_at")
    }
}
