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
  func viewWillAppear() {
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    memes = appDelegate.memes
  }
  
  

}
