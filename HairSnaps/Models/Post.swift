//
//  Post.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Post Class;
class Post: NSObject {
    
    var id: Int!
    
    var user: User!
    var location: Location!
    
    var image: Image!
    var image1: Image!
    var image2: Image!
    var image3: Image!

    var salon: GenericObject!
    var salon_location: SalonLocation!
    
    var stylist: Stylist!
    var is_stylist: Bool!
    
    var min_price: String!
    var price: String!
    
    var color_name: String!
    var colors: NSMutableArray!
    
    var length: GenericObject!
    
    var occasion_name: String!
    var occasions: NSMutableArray!
    
    var tags: [AnyObject]!

    var caption: String!

    var user_likes_count: Int!
    var user_likes: NSMutableArray!
    var does_user_likes: Bool!

    var user_comments_count: Int!
    var comments: NSMutableArray!
    
    var created_at: String!
    var updated_at: String!
    
    class func post(attributes: NSDictionary!) -> Post? {
        if(attributes == nil) {
            return nil
        }
        
        return Post(attributes: attributes)
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        setAttributes(attributes)
    }
    
    func setAttributes(attributes: NSDictionary!) {
        // Set;
        id = attributes.integerForKey("post_id")
        
        user = User(attributes: attributes.dictionaryForKey("user"))
        location = Location.location(attributes.dictionaryForKey("location"))
        
        image = Image.image(attributes.dictionaryForKey("image"))
        image1 = Image.image(attributes.dictionaryForKey("image1"))
        image2 = Image.image(attributes.dictionaryForKey("image2"))
        image3 = Image.image(attributes.dictionaryForKey("image3"))
        
        salon = GenericObject.genericObject(attributes.dictionaryForKey("salon"))
        salon_location = SalonLocation.salonLocation(attributes.dictionaryForKey("salon_location"))
        
        stylist = Stylist.stylist(attributes.dictionaryForKey("stylist"))
        is_stylist = attributes.boolForKey("is_stylist")
        
        min_price = attributes.stringForKey("min_price")
        price = attributes.stringForKey("price")
        
        color_name = attributes.stringForKey("color_name")
        colors = NSMutableArray()
        
        length = GenericObject.genericObject(attributes.dictionaryForKey("length"))
        
        occasion_name = attributes.stringForKey("occasion_name")
        occasions = NSMutableArray()
        
        tags = attributes.arrayForKey("tags")
        
        caption = attributes.stringForKey("description")
        
        user_likes_count = attributes.integerForKey("user_likes_count")
        user_likes = NSMutableArray()
        does_user_likes = attributes.boolForKey("does_user_likes")
        
        user_comments_count = attributes.integerForKey("user_comments_count")
        comments = Comment.comments(attributes.arrayForKey("comments"))
        
        created_at = attributes.stringForKey("created_at")
        updated_at = attributes.stringForKey("updated_at")
    }
}
