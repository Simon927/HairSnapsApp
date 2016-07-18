//
//  MapViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import CoreLocation
import MapKit

// --- Defines ---;
// MapViewController Class;
class MapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    @IBOutlet weak var postView: UICollectionView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!

    @IBOutlet weak var mapView: MKMapView!
    
    var expanding: Bool = false {
        didSet {
            self.postView.allowsSelection = !expanding
            self.postView.scrollEnabled = !expanding
            self.mapView.scrollEnabled = expanding
            self.mapView.zoomEnabled = expanding
            self.mapView.rotateEnabled = expanding
        }
    }

    var location: Location! = nil
    var salon: GenericObject! = nil
    
    var posts: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar;
        if (salon != nil && salon.name != "") {
            navigationItem.title = salon.name
        } else if (location.city != "" && location.state != "") {
            navigationItem.title = location.city + " " + location.state
        } else {
            navigationItem.title = location.name
        }
        
        // Collection View;
        let layout: CHTCollectionViewWaterfallLayout! = postView?.collectionViewLayout as CHTCollectionViewWaterfallLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 4, 4, 4)
        layout.headerHeight = 0
        layout.footerHeight = 0
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        postView.contentInset = UIEdgeInsetsMake(contentHeight.constant, 0, 0, 0)
        postView.scrollIndicatorInsets = UIEdgeInsetsMake(contentHeight.constant, 0, 0, 0)
 
        let postViewGesture = UITapGestureRecognizer(target: self, action: Selector("onPostViewGesture:"))
        postView.addGestureRecognizer(postViewGesture)
        
        // Map View;
        let mapViewGesture = UITapGestureRecognizer(target: self, action: Selector("onMapViewGesture:"))
        mapView.addGestureRecognizer(mapViewGesture)
        
        // Load;
        loadPosts()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = postView.dequeueReusableCellWithReuseIdentifier("PostCell", forIndexPath: indexPath) as PostCell
//      cell.delegate = self
        cell.post = posts[indexPath.row] as Post
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let width: CGFloat = (collectionView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        cell.contentView.frame = CGRectMake(0, 0, width, height)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        let size: CGSize = CGSizeMake(width, height)
        return size
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!expanding) {
            // Post View;
            postView.scrollIndicatorInsets = UIEdgeInsetsMake(-postView.contentOffset.y, 0, 0, 0)
            
            // Content;
            contentHeight.constant =  max(-postView.contentOffset.y, 0)
        }
    }
    
    func onPostViewGesture(tapGesture: UITapGestureRecognizer) {
        if (expanding) {
            // Expanding;
            expanding = false
            
            // Animation;
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                // Content View;
                self.contentHeight.constant = 191
                self.contentView.layoutIfNeeded()
                
                self.postView.contentOffset = CGPoint(x: 0, y: -self.contentHeight.constant)
                self.postView.contentInset = UIEdgeInsetsMake(self.contentHeight.constant, 0, 0, 0)
                self.postView.scrollIndicatorInsets = UIEdgeInsetsMake(self.contentHeight.constant, 0, 0, 0)
            })
        }
    }
    
    func onMapViewGesture(tapGesture: UITapGestureRecognizer) {
        if (!expanding) {
            // Expanding;
            expanding = true
            
            // Animation;
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                // Content View;
                self.contentHeight.constant = self.view.bounds.height - 129
                self.contentView.layoutIfNeeded()
                
                self.postView.contentOffset = CGPoint(x: 0, y: -self.contentHeight.constant)
                self.postView.contentInset = UIEdgeInsetsMake(self.contentHeight.constant, 0, 0, 0)
                self.postView.scrollIndicatorInsets = UIEdgeInsetsMake(self.contentHeight.constant, 0, 0, 0)
            })
        }
    }
    
    func loadPosts() {
        APIClient.sharedClient.searchPostsByLocation(location, completion: { (posts) -> Void in
            // Remove All Posts;
            self.posts.removeAllObjects()
            
            // Add Posts;
            self.posts.addObjectsFromArray(posts)
            
            // Reload;
            self.postView.reloadData()
            
            // Pins;
            self.addPins()
        })
    }
    
    func addPins() {
        for postItem in posts {
            let post: Post! = postItem as Post
            let location: SalonLocation! = post.salon_location
            
            let annotation = MapAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            annotation.title = ""
            annotation.subtitle = "and " + "10" + " more posts"
            annotation.post = post
            mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
