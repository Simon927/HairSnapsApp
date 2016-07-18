//
//  Comment.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Comment Class;
class Comment: NSObject {
    var id: Int!
    var user: User!
    var body: String!
    var user_id: Int!
    var post_id: Int!
    var created_at: String!
    var updated_at: String!
    
    class func comments(commentArray: NSArray!) -> NSMutableArray? {
        let comments = NSMutableArray()
        
        if (commentArray != nil) {
            for commentDictionary in commentArray {
                let comment = Comment(attributes: commentDictionary["comment"] as NSDictionary)
                comments.insertObject(comment, atIndex: 0)
            }
        }
        
        return comments
    }
    
    override init() {
        super.init()
    }
    
    init(attributes: NSDictionary!) {
        super.init()
        
        // Set;
        setAttributes(attributes)
    }
    
    func setAttributes(attributes: NSDictionary!) {
        id = attributes.integerForKey("id")
        user = User(attributes: attributes.dictionaryForKey("user"))
        body = attributes.stringForKey("body")
        user_id = attributes.integerForKey("user_id")
        post_id = attributes.integerForKey("post_id")
        created_at = attributes.stringForKey("created_at")
        updated_at = attributes.stringForKey("updated_at")
    }
}
