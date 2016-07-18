//
//  Pagination.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Pagination Class;
class Pagination: NSObject {
    
    var current: Int!
    var pages: Int!
    var per_page: Int!
    var count: Int!
    var previous: String!
    var next: String!
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        current = attributes.integerForKey("current")
        pages = attributes.integerForKey("pages")
        per_page = attributes.integerForKey("per_page")
        count = attributes.integerForKey("count")
        previous = attributes.stringForKey("previous")
        next = attributes.stringForKey("next")
    }
}
