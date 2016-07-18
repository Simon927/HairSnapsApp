//
//  Price.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Price Class;
class Price: NSObject {
    
    var id: Int!
    var min_price: Int!
    var max_price: Int!
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        min_price = attributes.integerForKey("min_price")
        max_price = attributes.integerForKey("max_price")
    }
}
