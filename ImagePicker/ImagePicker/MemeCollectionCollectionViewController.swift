//
//  MemeCollectionCollectionViewController.swift
//  ImagePicker
//
//  Created by Benjamin Johnston on 6/22/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MemeCollectionCollectionViewController: UICollectionViewController {

  var memes: [Meme]!
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    memes = appDelegate.memes
    self.collectionView?.reloadData()
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! MemeCollectionViewCell
    let meme = self.memes[indexPath.row]
    
    // Set the name and image
    cell.image.image = meme.memedImage
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
  {
    let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    detailController.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }
}
