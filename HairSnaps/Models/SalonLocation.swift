//
//  SalonLocation.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// SalonLocation Class;
class SalonLocation: NSObject {
    
    var latitude: Double!
    var longitude: Double!
    var name: String!
    var posts_count: Int!
    var latest_images: NSArray!
    
    class func salonLocation(attributes: NSDictionary!) -> SalonLocation? {
        if (attributes == nil) {
            return nil
        }
        
        return SalonLocation(attributes: attributes)
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        latitude = attributes.doubleForKey("latitude")
        longitude = attributes.doubleForKey("longitude")
        name = attributes.stringForKey("name")
        posts_count = attributes.integerForKey("posts_count")
        latest_images = attributes.arrayForKey("latest_images")
    }
}
