//
//  DetailViewController.swift
//  ImagePicker
//
//  Created by Benjamin Johnston on 6/24/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailImage: UIImageView!
  var meme: Meme?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.detailImage.image = self.meme?.memedImage
    
  }
  
}
