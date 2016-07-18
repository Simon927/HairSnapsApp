//
//  WalkthroughViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// WalkthroughViewController Class;
class WalkthroughViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {

    @IBOutlet weak var postView: UICollectionView!

    var refreshControl: UIRefreshControl!
    
    var posts: NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Full Screen;
//      fullScreenScroll = YIFullScreenScroll(viewController: self, scrollView: postView, style: YIFullScreenScrollStyle.Facebook)

        // Collection View;
//      postView.contentInset = UIEdgeInsetsMake(108, 0, 49, 0)
//      postView.scrollIndicatorInsets = UIEdgeInsetsMake(108, 0, 49, 0)
        
        // Refresh Control;
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadPosts", forControlEvents: UIControlEvents.ValueChanged)
        postView.addSubview(refreshControl)
        
        // Collection View;
        let layout: CHTCollectionViewWaterfallLayout! = postView.collectionViewLayout as CHTCollectionViewWaterfallLayout
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        layout.headerHeight = 0
        layout.footerHeight = 0
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        // Load;
        loadPosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = postView.dequeueReusableCellWithReuseIdentifier("PostCell", forIndexPath: indexPath) as PostCell
        cell.post = posts[indexPath.row] as Post
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let width: CGFloat = (postView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        cell.contentView.frame = CGRectMake(0, 0, width, height)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
   
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (postView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        let size: CGSize = CGSizeMake(width, height)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPostController") as WalkthroughPostController
        viewController.post = posts[indexPath.row] as Post
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Login") {
            let viewController = segue.destinationViewController as SignViewController
            viewController.navigationItem.title = "LOG IN"
        } else if (segue.identifier == "Register") {
            let viewController = segue.destinationViewController as SignViewController
            viewController.navigationItem.title = "SIGN UP"
        }
    }
    
    func loadPosts() {
        APIClient.sharedClient.walkthroughPosts({ (posts) -> Void in
            // Remove All Posts;
            self.posts.removeAllObjects()
            
            // Add Posts;
            self.posts.addObjectsFromArray(posts)
            self.postView.reloadData()
        })
    }
}
