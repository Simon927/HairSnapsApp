//
//  Image.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Image Class;
class Image: NSObject {
    
    var default_image: String!
    var default_image_retina: String!
    var large: String!
    var large_retina: String!
    var thumb: String!
    var thumb_retina: String!
    
    class func image(attributes: NSDictionary!) -> Image? {
        if (attributes == nil) {
            return nil
        }
        
        return Image(attributes: attributes)
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        default_image = attributes.stringForKey("default_image")
        default_image_retina = attributes.stringForKey("default_image_retina")
        large = attributes.stringForKey("large")
        large_retina = attributes.stringForKey("large_retina")
        thumb = attributes.stringForKey("thumb")
        thumb_retina = attributes.stringForKey("thumb_retina")
    }
}
