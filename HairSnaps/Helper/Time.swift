//
//  Time.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// Time Class;
class Time: NSObject {
   
    class func timeAgo(time: String) -> String {
        // Date;
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date: NSDate! = formatter.dateFromString(time)
        let interval = Int(date.timeIntervalSinceNow)
        
        let kScond = 1
        let kMinute = 60 * kScond
        let kHour = 60 * kMinute
        let kDay = 24 * kHour
        
        if (interval <= 0) {
            return "1s ago"
        } else if (interval == kScond) {
            return "1s ago";
        } else if (interval < 1 * kMinute) {
            return String(interval) + "s ago"
        } else if (interval < 2 * kMinute) {
            return "1m ago"
        } else if (interval < 1 * kHour) {
            return String(interval / kMinute) + "m ago"
        } else if (interval < 2 * kHour) {
            return "1h ago";
        } else if (interval < 24 * kHour) {
            return String(interval / kHour) + "h ago"
//          return [NSString stringWithFormat:@"%ih ago", iDate/HOUR];
        } else if (interval < 48 * kHour) {
            return "1d ago";
        } else if (interval < 30 * kDay) {
            return String(interval / kDay) + "d ago"
        }
        
        return "Error parsing date"
    }
}
