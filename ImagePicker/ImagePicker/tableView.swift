//
//  tableView.swift
//  ImagePicker
//
//  Created by Benjamin Johnston on 6/11/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit

class tableView: UITableViewController, UITableViewDataSource, UITableViewDelegate {
  
  var memes: [Meme]!
  var test = ["1", "2", "3", "4", "5"]
  func viewWillAppear() {
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    memes = appDelegate.memes
  }
  
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
    let num = self.test[indexPath.row]
    
    // Set the name and image
    cell.textLabel?.text = num

    
    // If the cell has a detail label, we will put the evil scheme in.

    
    return cell
  }

}
