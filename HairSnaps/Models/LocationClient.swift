//
//  LocationClient.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import CoreLocation

// --- Defines ---;
// Google API URL;
let kGoogleURLString = "https://maps.googleapis.com/maps/api"

// Google API KEY;
let kGoogleAPIKey = "AIzaSyCzrrlVfdwg7kaZrh0dvajRoZJVi-slTj4"

// LocationClient Class;
class LocationClient: AFHTTPSessionManager, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var location: CLLocation!
    
    class var sharedClient: LocationClient {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var client: LocationClient? = nil
        }
        dispatch_once(&Static.onceToken) {
            let url = NSURL(string: kGoogleURLString)
            Static.client = LocationClient(baseURL: url)
            
            // Response;
            let responseSerializer = AFJSONResponseSerializer()
            responseSerializer.acceptableContentTypes = responseSerializer.acceptableContentTypes.setByAddingObject("text/html")
            Static.client?.responseSerializer = responseSerializer
        }
        return Static.client!
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        location = newLocation
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {

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
    
    func startUpdatingLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization"))) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func places(nearby coordinate: CLLocationCoordinate2D, type: String, keyword: String, completion: ((places: [AnyObject]!, nextPageToken: String!) -> Void)!) {
        let parameters = [
            "location": NSString(format: "%f,%f", coordinate.latitude, coordinate.longitude),
            "types": "beauty_salon|hair_care|spa",
            "name": keyword,
            "sensor": "true",
            "rankby": "distance",
            "keyword": keyword,
            "key": kGoogleAPIKey
        ]
        
        // Post;
        GET("place/nearbysearch/json", parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var places: NSMutableArray! = NSMutableArray()
            var nextPageToken: String! = nil
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary

                // Places;
                let results = responseDictionary.arrayForKey("results")
                
                for result in results {
                    let place = Place(attributes: result as NSDictionary)
                    places.addObject(place)
                }
                
                // Next Page Token;
                nextPageToken = responseDictionary.stringForKey("next_page_token")
            }
            
            if (completion != nil) {
                completion(places: places, nextPageToken: nextPageToken)
            }
        })
    }
    
    func places(pageToken: String!, completion: ((places: [AnyObject]!, nextPageToken: String!) -> Void)!) {
        let parameters = [
            "sensor": "true",
            "pagetoken": pageToken,
            "key": kGoogleAPIKey
        ]
        
        // Post;
        GET("place/nearbysearch/json", parameters: parameters, completion: { (responseObject: AnyObject!, error: NSError!) -> Void in
            var places: NSMutableArray! = NSMutableArray()
            var nextPageToken: String! = nil
            
            if (error == nil) {
                let responseDictionary: NSDictionary! = responseObject as NSDictionary

                // Places;
                let results = responseDictionary.arrayForKey("results")
                
                for result in results {
                    let place = Place(attributes: result as NSDictionary)
                    places.addObject(place)
                }
                
                // Next Page Token;
                nextPageToken = responseDictionary.stringForKey("next_page_token")
            }
            
            if (completion != nil) {
                completion(places: places, nextPageToken: nextPageToken)
            }
        })
    }
    
    func place(place: Place!, completion: ((successed: Bool!) -> Void)!) {
        let location = CLLocation(latitude: CLLocationDegrees(place.latitude), longitude: CLLocationDegrees(place.longitude))
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                let placemark = placemarks[0] as CLPlacemark
                place.city = placemark.locality
                place.state = placemark.administrativeArea
            }
            
            if (completion != nil) {
                completion(successed: (error == nil))
            }
        })
    }
}
