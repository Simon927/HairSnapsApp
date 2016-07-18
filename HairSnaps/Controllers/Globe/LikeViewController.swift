//
//  LikeViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// LikeViewController Class;
class LikeViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout, PostCellDelegate {

    weak var user: User! = nil
    
    var likes: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Collection View;
        let layout: CHTCollectionViewWaterfallLayout! = collectionView?.collectionViewLayout as CHTCollectionViewWaterfallLayout
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        layout.headerHeight = 0
        layout.footerHeight = 0
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        // Load;
        loadLikes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostCell", forIndexPath: indexPath) as PostCell
        cell.delegate = self
        cell.post = likes[indexPath.row] as Post
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as PostViewController
        viewController.post = likes[indexPath.row] as Post
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
                let index = self.likes.indexOfObject(post)
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                
                // Reload;
                self.collectionView?.reloadItemsAtIndexPaths([indexPath])
            }
        })
    }
    
    func loadLikes() {
        APIClient.sharedClient.likes(user, completion: { (posts) -> Void in
            // Remove All Posts;
            self.likes.removeAllObjects()
            
            // Add Posts;
            self.likes.addObjectsFromArray(posts)
            
            // Reload;
            self.collectionView?.reloadData()
        })
    }
    
    @IBAction func onBtnBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
