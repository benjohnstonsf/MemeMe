//
//  ViewController.swift
//  ImagePicker
//
//  Created by Benjamin Johnston on 6/3/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
  ]

  @IBOutlet weak var imagePickerView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var top: UITextField!
  @IBOutlet weak var bottom: UITextField!
  @IBOutlet weak var toolBar: UIToolbar!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var navBar: UINavigationBar!
  
  //Set View Context
  override func viewDidLoad() {
    super.viewDidLoad()
    top.defaultTextAttributes = memeTextAttributes
    bottom.defaultTextAttributes = memeTextAttributes
    top.delegate = self
    bottom.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    shareButton.enabled = false
    self.subscribeToKeyboardNotifications()    
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.unsubscribeFromKeyboardNotifications()
  }
  
  
  
  //Image Picker Behavior
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    let image = info[UIImagePickerControllerOriginalImage]! as! UIImage
    imagePickerView.image = image
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  //Keyboard Shifting
  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name:
      UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name:
      UIKeyboardWillHideNotification, object: nil)
  }
  func keyboardWillShow(notification: NSNotification) {
    if bottom.isFirstResponder() {
      self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  func keyboardWillHide(notification: NSNotification) {
    if bottom.isFirstResponder() {
      self.view.frame.origin.y = 0
    }
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }
  
  //Textfield Delegation
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if imagePickerView.image != nil && top.text != nil && bottom.text != nil {
      shareButton.enabled = true
    }
    return true
  }
  func textFieldDidBeginEditing(textField: UITextField) {

  }
  
  //Meme Saving Behavior
  func generateMemedImage() -> UIImage {
    self.toolBar.hidden = true
    self.navBar.hidden = true
    UIGraphicsBeginImageContext(self.view.frame.size)
    self.view.drawViewHierarchyInRect(self.view.frame,
      afterScreenUpdates: true)
    let memedImage : UIImage =
    UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.toolBar.hidden = false
    self.navBar.hidden = false
    return memedImage
  }
  
  func save() {
    let memedImage = generateMemedImage()
    var meme = Meme( text_top: self.top.text, text_bottom: self.bottom.text, image:
      imagePickerView.image!, memedImage: memedImage)
    (UIApplication.sharedApplication().delegate as!
      AppDelegate).memes.append(meme)
  }

  @IBAction func cancelAdd(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  @IBAction func shareMeme(sender: AnyObject) {
    self.save()
    let memes = (UIApplication.sharedApplication().delegate as!
      AppDelegate).memes
    let shareController = UIActivityViewController(activityItems: [memes[0].memedImage], applicationActivities: nil)
    
    self.presentViewController(shareController, animated: true, completion: nil)
    
  }
  
  
  //Actions For Choosing Image
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

