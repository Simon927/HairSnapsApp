//
//  Place.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import CoreLocation

// --- Defines ---;
// Place Class;
class Place: NSObject {
    
    var id: Int!
    var latitude: Float!
    var longitude: Float!
    var name: String!
    var address: String!
    var city: String!
    var state: String!
    var icon: String!
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        
        let geometry = attributes.dictionaryForKey("geometry") as NSDictionary
        let location = geometry.dictionaryForKey("location") as NSDictionary
        latitude = location.floatForKey("lat")
        longitude = location.floatForKey("lng")
        
        name = attributes.stringForKey("name")
        address = attributes.stringForKey("vicinity")
        icon = attributes.stringForKey("icon")
    }
}
