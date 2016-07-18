//
//  ProfileViewController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// ProfileViewController Class;
class ProfileViewController: UIViewController, CHTCollectionViewDelegateWaterfallLayout, ProfileHeaderDelegate, PostCellDelegate {

    @IBOutlet weak var accountView: UICollectionView!
    
    var posts: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar;
        navigationItem.title = Account.me.username
        
        // Header;
        let headerNib = UINib(nibName: "ProfileHeaderView", bundle: nil)
        accountView.registerNib(headerNib, forSupplementaryViewOfKind: CHTCollectionElementKindSectionHeader, withReuseIdentifier: "ProfileHeaderView")

        // Cell;
        let layout: CHTCollectionViewWaterfallLayout! = accountView.collectionViewLayout as CHTCollectionViewWaterfallLayout
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        // Load;
        loadPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, heightForHeaderInSection section: Int) -> CGFloat {
        return 242.0
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = accountView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ProfileHeaderView", forIndexPath: indexPath) as ProfileHeaderView
        headerView.delegate = self
        headerView.user = Account.me
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = accountView.dequeueReusableCellWithReuseIdentifier("PostCell", forIndexPath: indexPath) as PostCell
        cell.delegate = self
        cell.post = posts[indexPath.row] as Post
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let width: CGFloat = (accountView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        cell.contentView.frame = CGRectMake(0, 0, width, height)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (accountView.bounds.width - 12 ) / 2
        let height: CGFloat = (indexPath.row % 2 == 0) ? 242.0 : 270.0
        let size: CGSize = CGSizeMake(width, height)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("PostViewController") as PostViewController
        viewController.post = posts[indexPath.row] as Post
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didFollowings() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("FollowingViewController") as FollowingViewController
        viewController.user = Account.me
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didFollowers() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("FollowerViewController") as FollowerViewController
        viewController.user = Account.me
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didLikes() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("LikeViewController") as LikeViewController
        viewController.user = Account.me
        navigationController?.pushViewController(viewController, animated: true)
    }

    func didTags() {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("TagViewController") as TagViewController
        viewController.user = Account.me
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
                self.accountView.reloadItemsAtIndexPaths([indexPath])
            }
        })
    }
    
    func loadPosts() {
        APIClient.sharedClient.posts(Account.me, completion: { (posts) -> Void in
            // Remove;
            self.posts.removeAllObjects()
            
            // Add;
            self.posts.addObjectsFromArray(posts)
            
            // Reload;
            self.accountView.reloadData()
        })
    }
}
