//
//  ImagePickerController.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit
import AssetsLibrary

// --- Defines ---;
// ImagePickerController Class;
class ImagePickerController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var nextItem: UIBarButtonItem!
    @IBOutlet weak var pickerView: UICollectionView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var groupView: UITableView!
    
    let assetsLibrary: ALAssetsLibrary! = ALAssetsLibrary()
    let groups: NSMutableArray! = NSMutableArray()
    let photos: NSMutableArray! = NSMutableArray()
    
    var selectedGroup: ALAssetsGroup! = nil {
        didSet {
            if (selectedGroup != nil) {
                // Title;
                let title = selectedGroup.valueForProperty(ALAssetsGroupPropertyName) as String
                groupButton.setTitle(title + " ▾", forState: UIControlState.Normal)
            }
        }
    }
    let selectedPhotos: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load;
        loadGroups()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Bar Button Item;
        nextItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 18)!], forState: UIControlState.Disabled)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let cell = pickerView.dequeueReusableCellWithReuseIdentifier("CameraCell", forIndexPath: indexPath) as UICollectionViewCell
            return cell
        } else {
            // Photo;
            let asset = photos[indexPath.row - 1] as ALAsset
            
            // Cell;
            let cell = pickerView.dequeueReusableCellWithReuseIdentifier("AssetCell", forIndexPath: indexPath) as AssetCell
            cell.asset = asset
            cell.badge = selectedPhotos.indexOfObject(asset)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let width: CGFloat = (pickerView.bounds.width - 8 ) / 3
        cell.contentView.frame = CGRectMake(0, 0, width, width)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (pickerView.bounds.width - 8 ) / 3
        let size: CGSize = CGSizeMake(width, width)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true) {
                let pickerController: UIImagePickerController! = UIImagePickerController()
                pickerController.delegate = self
                pickerController.editing = false
                pickerController.sourceType = UIImagePickerControllerSourceType.Camera
                presentViewController(pickerController, animated: true, completion: nil)
            }
        } else {
            let asset = photos[indexPath.row - 1] as ALAsset
            let index = selectedPhotos.indexOfObject(asset)
            
            if (index != NSNotFound) {
                // Remove;
                selectedPhotos.removeObject(asset)
                
                // Reload;
                pickerView.reloadData()
            } else if (selectedPhotos.count < 4 ) {
                selectedPhotos.addObject(asset)
                
                // Reload;
                pickerView.reloadItemsAtIndexPaths([indexPath])
            }
            
            // Next;
            nextItem.enabled = selectedPhotos.count != 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Group;
        let group = groups[indexPath.row] as ALAssetsGroup
        
        // Cell;
        let cell = groupView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath) as GroupCell
        cell.group = group
//      cell.selected = group == selectedGroup
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Group;
        let group = groups[indexPath.row] as ALAssetsGroup
        
        // Set;
        selectedGroup = group
        
        // Reload;
        loadPhotos()
        
        // Hide;
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.contentView.hidden = true
        })
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        // Set;
        let postController = navigationController as PostNavigationController
        postController.frontImage = image

        // Dismiss;
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            // Post Create;
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("PostCreateController") as PostCreateController
            self.navigationController?.pushViewController(viewController, animated: true)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadGroups () {
        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group: ALAssetsGroup!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if (group != nil) {
                // Group;
                self.groups.addObject(group)
                
                // Photos;
                group.enumerateAssetsUsingBlock({ (asset: ALAsset!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                    if (asset != nil){
                        self.photos.addObject(asset)
                    }
                })
            } else {
                // Groups;
                self.groupView.reloadData()
                
                // Photos;
                self.pickerView.reloadData()
            }
        }, failureBlock: { (error: NSError!) -> Void in
            
        })
    }
    
    func loadPhotos () {
        // Title;

        // Remove All Objects;
        photos.removeAllObjects()
        
        // Photos;
        selectedGroup.enumerateAssetsUsingBlock({ (asset: ALAsset!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if (asset != nil){
                self.photos.addObject(asset)
            } else {
                // Photos;
                self.pickerView.reloadData()
            }
        })
    }
    
    @IBAction func onBtnClose(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onBtnGroup(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.contentView.hidden = !self.contentView.hidden
        })
    }
    
    @IBAction func onBtnNext(sender: AnyObject) {
        // Photos;
        let postController = navigationController as PostNavigationController
        
        if (selectedPhotos.count > 0) {
            let asset = selectedPhotos[0] as ALAsset
            let image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
            postController.frontImage = image
        }
        
        if (selectedPhotos.count > 1) {
            let asset = selectedPhotos[1] as ALAsset
            let image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
            postController.side1Image = image
        }
        
        if (selectedPhotos.count > 2) {
            let asset = selectedPhotos[2] as ALAsset
            let image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
            postController.side2Image = image
        }

        if (selectedPhotos.count > 3) {
            let asset = selectedPhotos[3] as ALAsset
            let image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
            postController.backImage = image
        }
        
        // Post Create;
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("PostCreateController") as PostCreateController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
