//
//  ViewController.swift
//  ImagePicker
//
//  Created by Benjamin Johnston on 6/3/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
//    NSStrokeWidthAttributeName : 1.0
  ]


  @IBOutlet weak var imagePickerView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var top: UITextField!
  @IBOutlet weak var bottom: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    top.defaultTextAttributes = memeTextAttributes
    bottom.defaultTextAttributes = memeTextAttributes
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

  }
  
  
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image = info[UIImagePickerControllerOriginalImage]! as! UIImage
    imagePickerView.image = image
    
    
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  @IBAction func pickAnImage(sender: AnyObject) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .PhotoLibrary
    self.presentViewController(pickerController, animated: true, completion: nil)
  }
  
  @IBAction func pickAnImageFromCamera (sender: AnyObject) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .Camera
    self.presentViewController(imagePicker, animated: true, completion: nil)
  }
  
}

