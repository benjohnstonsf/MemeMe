//
//  tableViewController.swift
//  ImagePicker
//
//  Created by Benjamin Johnston on 6/11/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit

class tableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var memes: [Meme]!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    memes = appDelegate.memes
    self.tableView.reloadData()    
  }
    
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
    let meme = self.memes[indexPath.row]
    cell.textLabel?.text = meme.text_top
    cell.imageView?.image = meme.image
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    detailController.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }
  
  


}
