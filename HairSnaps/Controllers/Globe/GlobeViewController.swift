//
//  GlobeViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// GlobeViewController Class;
class GlobeViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout, PostCellDelegate {
    
    @IBOutlet weak var postView: UICollectionView!
    
    var refreshControl: UIRefreshControl!
    
    var posts: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Full Screen;
//      fullScreenScroll = YIFullScreenScroll(viewController: self, scrollView: postView, style: YIFullScreenScrollStyle.Facebook)
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Collection View;
        postView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomLayoutGuide.length, right: 0)
        postView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomLayoutGuide.length, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = false
        searchBar.sizeToFit()
        
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Cell;
        var cell: UITableViewCell! = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SearchCell")
        cell.textLabel?.text = "Test"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = postView.dequeueReusableCellWithReuseIdentifier("PostCell", forIndexPath: indexPath) as PostCell
        cell.delegate = self
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
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as PostViewController
        viewController.post = posts[indexPath.row] as Post
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didSelectUser(user: User!) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("UserViewController") as UserViewController
        viewController.user = user
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didLike(post: Post!) {
        // Like;
        APIClient.sharedClient.likePost(post, completion: { (successed) -> Void in
            if (!successed) {
                AZNotification.showNotificationWithTitle("Failed to Like.", controller: self, notificationType: AZNotificationType.Error)
            } else {
                let index = self.posts.indexOfObject(post)
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                
                // Reload;
                self.postView.reloadItemsAtIndexPaths([indexPath])
            }
        })
    }
    
    func loadPosts() {
        APIClient.sharedClient.globePosts({ (posts) -> Void in
            // Remove All Posts;
            self.posts.removeAllObjects()
            
            // Add Posts;
            self.posts.addObjectsFromArray(posts)
            
            // Reload;
            self.postView.reloadData()
        })
    }
}
