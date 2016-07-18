//
//  TagViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// TagViewController Class;
class TagViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout, PostCellDelegate {

    @IBOutlet weak var approveControl: UISegmentedControl!
    @IBOutlet weak var tagView: UICollectionView!
    
    weak var user: User! = nil
    
    var posts: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cell;
        let layout: CHTCollectionViewWaterfallLayout! = tagView.collectionViewLayout as CHTCollectionViewWaterfallLayout
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        // Load;
        loadStylists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = tagView.dequeueReusableCellWithReuseIdentifier("PostCell", forIndexPath: indexPath) as PostCell
//      cell.delegate = self
        cell.post = posts[indexPath.row] as Post
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let width: CGFloat = (tagView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        cell.contentView.frame = CGRectMake(0, 0, width, height)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (tagView.bounds.width - 12 ) / 2
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
                self.tagView.reloadItemsAtIndexPaths([indexPath])
            }
        })
    }

    func loadStylists() {
        APIClient.sharedClient.stylists(user, approved: approveControl.selectedSegmentIndex == 0, completion: { (posts) -> Void in
            // Remove;
            self.posts.removeAllObjects()
            
            // Add;
            self.posts.addObjectsFromArray(posts)
            
            // Reload;
            self.tagView.reloadData()
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        loadStylists()
    }
}
