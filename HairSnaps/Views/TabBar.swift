//
//  TabBar.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// TabBarDelegate Protocol;
protocol TabBarDelegate: NSObjectProtocol {
    func tabBar(tabBar: TabBar, didSelectIndex index: Int)
    func tabBarDidCamera(tabBar: TabBar)
}

// TabBar Class;
class TabBar: UIView {
    @IBOutlet weak var globeButton: UIButton!
    @IBOutlet weak var communityButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var delegate: TabBarDelegate! = nil
    
    var selectedIndex: Int = -1 {
        willSet {
            // Prev
            if (selectedIndex != newValue) {
                switch (selectedIndex) {
                case 0:
                    globeButton.setImage(UIImage(named: "tabbar_globe"), forState: UIControlState.Normal)
                    globeButton.adjustsImageWhenHighlighted = true
                    break
                    
                case 1:
                    communityButton.setImage(UIImage(named: "tabbar_community"), forState: UIControlState.Normal)
                    communityButton.adjustsImageWhenHighlighted = true
                    break
                    
                case 2:
                    notificationButton.setImage(UIImage(named: "tabbar_notification"), forState: UIControlState.Normal)
                    notificationButton.adjustsImageWhenHighlighted = true
                    break
                    
                case 3:
                    profileButton.setImage(UIImage(named: "tabbar_profile"), forState: UIControlState.Normal)
                    profileButton.adjustsImageWhenHighlighted = true
                    break
                    
                default:
                    break
                }
            }
            
            // Current;
            if (selectedIndex != newValue) {
                switch (newValue) {
                case 0:
                    globeButton.setImage(UIImage(named: "tabbar_globe_selected"), forState: UIControlState.Normal)
                    globeButton.adjustsImageWhenHighlighted = false
                    break
                    
                case 1:
                    communityButton.setImage(UIImage(named: "tabbar_community_selected"), forState: UIControlState.Normal)
                    communityButton.adjustsImageWhenHighlighted = false
                    break
                    
                case 2:
                    notificationButton.setImage(UIImage(named: "tabbar_notification_selected"), forState: UIControlState.Normal)
                    notificationButton.adjustsImageWhenHighlighted = false
                    break
                    
                case 3:
                    profileButton.setImage(UIImage(named: "tabbar_profile_selected"), forState: UIControlState.Normal)
                    profileButton.adjustsImageWhenHighlighted = false
                    break
                    
                default:
                    break
                }
            }
            
            if (delegate.respondsToSelector(Selector("tabBar:didSelectIndex:"))) {
                delegate.tabBar(self, didSelectIndex: newValue)
            }
        }
    }
    
    @IBAction func onBtnGlobe(sender: AnyObject) {
        selectedIndex = 0
    }
    
    @IBAction func onBtnCommunity(sender: AnyObject) {
        selectedIndex = 1
    }

    @IBAction func onBtnCamera(sender: AnyObject) {
        if (delegate.respondsToSelector(Selector("tabBarDidCamera:"))) {
            delegate.tabBarDidCamera(self)
        }
    }
    
    @IBAction func onBtnNotification(sender: AnyObject) {
        selectedIndex = 2
    }
    
    @IBAction func onBtnProfile(sender: AnyObject) {
        selectedIndex = 3
    }
}
