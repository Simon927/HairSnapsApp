//
//  APIClient.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// API Base URL;
let kAPIBaseURLString = "http://haircrush_api.mashup.li"

// APIClient Class;
class APIClient: AFHTTPSessionManager {
    
    class var sharedClient: APIClient {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var client: APIClient? = nil
        }
        dispatch_once(&Static.onceToken) {
            let url = NSURL(string: kAPIBaseURLString)
            Static.client = APIClient(baseURL: url)
            
            // Response;
            let responseSerializer = AFJSONResponseSerializer()
            responseSerializer.acceptableContentTypes = responseSerializer.acceptableContentTypes.setByAddingObject("text/html")
            Static.client?.responseSerializer = responseSerializer
        }
        return Static.client!
    }
    
    func GET(urlString: String!, parameters: AnyObject!, completion: ((AnyObject!, NSError!) -> Void)!) {
        GET(urlString, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            if (completion != nil) {
                completion(responseObject, nil)
            }
        }, failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
            if (completion != nil) {
                completion(nil, error)
            }
        })
    }
    
    func POST(urlString: String!, parameters: AnyObject!, completion: ((AnyObject!, NSError!) -> Void)!) {
        POST(urlString, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            if (completion != nil) {
                completion(responseObject, nil)
            }
        }, failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
            if (completion != nil) {
                completion(nil, error)
            }
        })
    }
    
    func POST(urlString: String!, parameters: AnyObject!, constructingBodyWithBlock block: ((AFMultipartFormData!) -> Void)!, completion: ((AnyObject!, NSError!) -> Void)!) {
        POST(urlString, parameters: parameters, constructingBodyWithBlock: block, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            if (completion != nil) {
                completion(responseObject, nil)
            }
        }, failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
            if (completion != nil) {
                completion(nil, error)
            }
        })
    }
    
    func DELETE(urlString: String!, parameters: AnyObject!, completion: ((AnyObject!, NSError!) -> Void)!) {
        DELETE(urlString, parameters: parameters, success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) -> Void in
            if (completion != nil) {
                completion(responseObject, nil)
            }
        }, failure: { (task: NSURLSessionDataTask!, error: NSError!) -> Void in
            if (completion != nil) {
                completion(nil, error)
            }
        })
    }
    
    func logout(completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/sign_out"
        
        // Parameters;
        let parameters = [
            "api_key": "redeem-registration",
            "auth_token": Account.me.authenticationToken
        ]
        
        // Delete;
        DELETE(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                Account.me.logout()
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func login(email: String!, password: String!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/sign_in"
        
        // Parameters;
        let parameters = [
            "api_key": "haircrush-registration",
            "user[email]": email,
            "user[password]": password
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                Account.me.setAttributes(responseObject["user"] as NSDictionary)
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func loginByFacebook(accessToken: String!, completion: ((successed: Bool) -> Void)!) {
        var systemInfo = [UInt8](count: sizeof(utsname), repeatedValue: 0)
        let model = systemInfo.withUnsafeMutableBufferPointer { (inout body: UnsafeMutableBufferPointer<UInt8>) -> String? in
            if uname(UnsafeMutablePointer(body.baseAddress)) != 0 {
                return nil
            }
            return String.fromCString(UnsafePointer(body.baseAddress.advancedBy(Int(_SYS_NAMELEN * 4))))
        }

        // Path;
        let path = "users/fb_login"
        
        // Parameters;
        let parameters = [
            "api_key": "redeem-registration",
            "phone_model": UIDevice.currentDevice().model,
            "phone_make": model,
            "fb_access_token": accessToken
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                Account.me.setAttributes(responseObject["user"] as NSDictionary)
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func loginByTwitter(token: String!, tokenSecret: String!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/twitter_login"
        
        // Parameters;
        let parameters = [
            "token": token,
            "token_secret": tokenSecret
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                Account.me.setAttributes(responseObject["user"] as NSDictionary)                
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func loginByGoogle(token: String!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/google_login"
        
        // Parameters;
        let parameters = [
            "token": token
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                Account.me.setAttributes(responseObject["user"] as NSDictionary)                
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func forgotPassword(email: String!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/reset_password"
        
        // Parameters;
        let parameters = [
            "email": email
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func register(username: String!, password: String!, email: String!, phone: String!, photo: UIImage!, completion: ((successed: Bool, error: String!) -> Void)!) {
        // Path;
        let path = "users"
        
        // Parameters;
        let parameters = [
            "api_key": "haircrush-registration",
            "user[username]": username,
            "user[password]": password,
            "user[password_confirmation]": password,
            "user[email]": email,
            "user[private_phone_number]": phone
        ]
        
        // Post;
        POST(path, parameters: parameters, constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
            if (photo != nil) {
                let data = UIImageJPEGRepresentation(photo, 0.75) as NSData
                formData.appendPartWithFileData(data, name: "photo", fileName: "file.jpeg", mimeType: "image/jpeg")
            }
        }, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                Account.me.setAttributes(responseObject["user"] as NSDictionary)
            }
                
            if (completion != nil) {
                if (error == nil) {
                    completion(successed: true, error: nil)
                } else {
                    let userInfo = error.userInfo as NSDictionary!
                    let data = userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as NSData!
                    let object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary!
                    let message = object["error"] as String
                    
                    completion(successed: false, error: message)
                }
            }
        })
    }
    
    func changePassword(email: String!, password: String!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/reset_password"
        
        // Parameters;
        let parameters = [
            "user[password]": password,
            "user[password_confirmation]": password,
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func viewUser(user: User!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "users/" + String(user.id)
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                user.setAttributes(responseObject["user"] as NSDictionary)
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func followings(user: User!, completion: ((followings: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "follow"
        
        // Parameters;
        let parameters = [
            "user_id": user.id,
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var followings: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Suggestions;
                let dictionaries = responseDictionary.arrayForKey("users")
                
                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let user = User(attributes: dictionary["user"] as NSDictionary)
                        followings.addObject(user)
                    }
                }
            }
            
            if (completion != nil) {
                completion(followings: followings)
            }
        })
    }
    
    func followers(user: User!, completion: ((followers: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "followers"
        
        // Parameters;
        let parameters = [
            "user_id": user.id,
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var followers: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Suggestions;
                let dictionaries = responseDictionary.arrayForKey("users")
                
                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let user = User(attributes: dictionary["user"] as NSDictionary)
                        followers.addObject(user)
                    }
                }
            }
            
            if (completion != nil) {
                completion(followers: followers)
            }
        })
    }
    
    func follow(user: User!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "follow"
        
        // Parameters;
        let parameters = [
            "following_id": user.id,
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func posts(user: User!, completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "users/" + String(user.id) + "/posts"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            let posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                let dictionaries: NSArray! = responseDictionary.arrayForKey("posts")

                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let post = Post(attributes: dictionary["post"] as NSDictionary)
                        posts.addObject(post)
                    }
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func likes(user: User!, completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "users/" + String(user.id) + "/likes"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            let posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let dictionaries: NSArray! = responseObject["posts"] as NSArray
                
                for dictionary in dictionaries {
                    let post = Post(attributes: dictionary["post"] as NSDictionary)
                    posts.addObject(post)
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func stylists(user: User!, approved: Bool, completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "stylists"
        
        // Parameters;
        let parameters = [
            "accepted": approved,
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            let posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                let dictionaries: NSArray! = responseDictionary.arrayForKey("posts")
                
                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let post = Post(attributes: dictionary["post"] as NSDictionary)
                        posts.addObject(post)
                    }
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func walkthroughPosts(completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "get_walkthrough"
        
        // Parameters;
        let parameters = [
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            let posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                let dictionaries: NSArray! = responseObject["posts"] as NSArray
                
                for dictionary in dictionaries {
                    let post = Post(attributes: dictionary["post"] as NSDictionary)
                    posts.addObject(post)
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func globePosts(completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "posts"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            let posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                let dictionaries: NSArray! = responseObject["posts"] as NSArray
                
                for dictionary in dictionaries {
                    let post = Post(attributes: dictionary["post"] as NSDictionary)
                    posts.addObject(post)
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func streamPosts(completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "users/stream"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var pagination: Pagination! = nil
            var posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                // Pagination;
                pagination = Pagination(attributes: responseObject["pagination"] as NSDictionary)
                
                // Posts;
                let dictionaries: NSArray! = responseObject["posts"] as NSArray
                
                for dictionary in dictionaries {
                    let post = Post(attributes: dictionary["post"] as NSDictionary)
                    posts.addObject(post)
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func searchPostsByLocation(location: Location, completion: ((posts: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "search"
        
        // Parameters;
        let parameters = [
            "latitude": location.latitude,
            "longitude": location.longitude,
            "radius": "5",
            "auth_token": Account.me.authenticationToken
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var pagination: Pagination! = nil
            var posts: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                // Pagination;
                pagination = Pagination(attributes: responseObject["pagination"] as NSDictionary)
                
                // Posts;
                let dictionaries: NSArray! = responseObject["posts"] as NSArray
                
                for dictionary in dictionaries {
                    let post = Post(attributes: dictionary["post"] as NSDictionary)
                    posts.addObject(post)
                }
            }
            
            if (completion != nil) {
                completion(posts: posts)
            }
        })
    }
    
    func postSnaps(frontImage: UIImage!, side1Image: UIImage!, side2Image: UIImage!, backImage: UIImage!, salon: Place!, stylist: User!, price: Price!, ownPrice: String!, detail: String!, caption: String!, completion: ((post: Post!, successed: Bool) -> Void)!) {
        // Path;
        let path = "posts"
        
        // Parameters;
        let parameters = [
            // Salon;
            "post[place][place_id]": salon.id,
            "post[place][latitude]": salon.latitude,
            "post[place][longitude]": salon.longitude,
            "post[place][salon_name]": salon.name,
            "post[place][name]": salon.address,
            "post[place][city]": salon.city,
            "post[place][state]": salon.state,
            
            // Stylist;
            "post[stylist_name]": "",
            
            // Price;
            "post[min_price]": "",
            "post[price]": "",
            
            // Color;
            "post[color_ids]": [],
            "post[color_name]": "",
            
            // Length;
            "post[length_id]": "",
            
            // Occasion;
            "post[occasion_ids]": [],
            "post[occasion_name]": "",
            
            // Tags;
            "post[tags]": detail != nil ? detail : "",
            
            // Caption;
            "post[description]": caption,
            
            // Share;
            "post[fb_share]": "0",
            "post[twitter_share]": "0",
            
            // Token;
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        POST(path, parameters: parameters, constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
            // Front;
            if (frontImage != nil) {
                let data = UIImageJPEGRepresentation(frontImage, 0.75) as NSData
                formData.appendPartWithFileData(data, name: "image", fileName: "file1.jpeg", mimeType: "image/jpeg")
            }
            
            // Side1;
            if (side1Image != nil) {
                let data = UIImageJPEGRepresentation(side1Image, 0.75) as NSData
                formData.appendPartWithFileData(data, name: "image1", fileName: "file2.jpeg", mimeType: "image/jpeg")
            }
            
            // Side2;
            if (side2Image != nil) {
                let data = UIImageJPEGRepresentation(side2Image, 0.75) as NSData
                formData.appendPartWithFileData(data, name: "image2", fileName: "file3.jpeg", mimeType: "image/jpeg")
            }
            
            // Back;
            if (backImage != nil) {
                let data = UIImageJPEGRepresentation(backImage, 0.75) as NSData
                formData.appendPartWithFileData(data, name: "image3", fileName: "file4.jpeg", mimeType: "image/jpeg")
            }
            }, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
                var post: Post! = nil
                
                if (error == nil) {
                    // Post;
                    post = Post(attributes: responseObject["post"] as NSDictionary)
                }
                
                if (completion != nil) {
                    completion(post: post, successed: (error == nil))
                }
        })
    }

    func viewPost(post: Post!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "get_post"
        
        // Parameters;
        let parameters = [
            "id": post.id
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var post: Post! = post
            
            if (error == nil) {
                post.setAttributes(responseObject["post"] as NSDictionary)
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func likePost(post: Post!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "posts/" + String(post.id) + "/like_post"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var post: Post! = post
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Like;
                post.does_user_likes = responseDictionary.boolForKey("success")
                
                // Likes;
                if (post.does_user_likes == true) {
                    post.user_likes_count = post.user_likes_count + 1
                } else {
                    post.user_likes_count = post.user_likes_count - 1
                }
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func deletePost(post: Post!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "posts/" + String(post.id)
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        DELETE(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func reportPost(post: Post!, message: String!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "posts/" + String(post.id) + "/report_abuse"
        
        // Parameters;
        let parameters = [
            "message": message,
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func comments(post: Post!, completion: ((comments: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "posts/" + String(post.id) + "/comments"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var comments: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Comments;
                let dictionaries = responseDictionary.arrayForKey("comments")
                
                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let comment = Comment(attributes: dictionary["comment"] as NSDictionary)
                        comments.insertObject(comment, atIndex: 0)
                    }
                }
            }
            
            if (completion != nil) {
                completion(comments: comments)
            }
        })
    }
    
    func postComment(comment: Comment!, forPost post: Post!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "posts/" + String(post.id) + "/comment"
        
        // Parameters;
        let parameters = [
            "body": comment.body,
            "mentions": "",
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        POST(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Comments;
                comment.setAttributes(responseDictionary.dictionaryForKey("comment"))
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func deleteComment(comment: Comment!, completion: ((successed: Bool) -> Void)!) {
        // Path;
        let path = "posts/" + String(comment.id) + "/delete_comment"
        
        // Parameters;
        let parameters = [
            "auth_token": Account.me.authenticationToken
        ]
        
        // Post;
        DELETE(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            if (error == nil) {

            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
    
    func suggestions(query: String, completion: ((suggestions: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "get_suggestions"
        
        // Parameters;
        let parameters = [
            "query": query
        ]

        // Post;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var suggestions: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Suggestions;
                let dictionaries = responseDictionary.arrayForKey("users")
                
                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let user = User(attributes: dictionary["user"] as NSDictionary)
                        suggestions.addObject(user)
                    }
                }
            }
            
            if (completion != nil) {
                completion(suggestions: suggestions)
            }
        })
    }
    
    func prices(completion: ((prices: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "get_prices"
        
        // Parameters;
        let parameters = [
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var prices: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                // Prices;
                let dictionaries: NSArray! = responseObject as NSArray
                for dictionary in dictionaries {
                    let price = Price(attributes: dictionary as NSDictionary)
                    prices.addObject(price)
                }
            }
            
            if (completion != nil) {
                completion(prices: prices)
            }
        })
    }
    
    func colors(completion: ((colors: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "get_colors"
        
        // Parameters;
        let parameters = [
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var colors: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                // Prices;
                let dictionaries: NSArray! = responseObject as NSArray
                for dictionary in dictionaries {
                    let color = Item(attributes: dictionary as NSDictionary)
                    colors.addObject(color)
                }
            }
            
            if (completion != nil) {
                completion(colors: colors)
            }
        })
    }
    
    func lengths(completion: ((lengths: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "get_lengths"
        
        // Parameters;
        let parameters = [
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var lengths: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                // Prices;
                let dictionaries: NSArray! = responseObject as NSArray
                for dictionary in dictionaries {
                    let length = Item(attributes: dictionary as NSDictionary)
                    lengths.addObject(length)
                }
            }
            
            if (completion != nil) {
                completion(lengths: lengths)
            }
        })
    }
    
    func occassions(completion: ((occassions: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "get_occassions"
        
        // Parameters;
        let parameters = [
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var occassions: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                // Prices;
                let dictionaries: NSArray! = responseObject as NSArray
                for dictionary in dictionaries {
                    let occassion = Item(attributes: dictionary as NSDictionary)
                    occassions.addObject(occassion)
                }
            }
            
            if (completion != nil) {
                completion(occassions: occassions)
            }
        })
    }
    
    func activities(completion: ((activities: [AnyObject]!) -> Void)!) {
        // Path;
        let path = "activities"
        
        // Parameters;
        let parameters = [
        ]
        
        // Get;
        GET(path, parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var activities: NSMutableArray! = NSMutableArray()
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary
                
                // Activities;
                let dictionaries = responseDictionary.arrayForKey("activities")
                
                if (dictionaries != nil) {
                    for dictionary in dictionaries {
                        let activity = Activity(attributes: dictionary["activity"] as NSDictionary)
                        activities.addObject(activity)
                    }
                }
            }
            
            if (completion != nil) {
                completion(activities: activities)
            }
        })
    }
}
