//
//  GenericObject.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// GenericObject Class;
class GenericObject: NSObject {
    
    var id: Int!
    var name: String!
    var created_at: String!
    var updated_at: String!
    
    class func genericObject(attributes: NSDictionary!) -> GenericObject? {
        if (attributes == nil) {
            return nil
        }
        
        return GenericObject(attributes: attributes)
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        id = attributes.integerForKey("id")
        name = attributes.stringForKey("name")
        created_at = attributes.stringForKey("created_at")
        updated_at = attributes.stringForKey("updated_at")
    }
}
