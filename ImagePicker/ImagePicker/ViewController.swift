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
//    NSStrokeWidthAttributeName : 1.0
  ]


  @IBOutlet weak var imagePickerView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var top: UITextField!
  @IBOutlet weak var bottom: UITextField!
  @IBOutlet weak var toolBar: UIToolbar!
  
  
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
    self.subscribeToKeyboardNotifications()

  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.unsubscribeFromKeyboardNotifications()
  }
  
  
  
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
      self.save()
      let memes = (UIApplication.sharedApplication().delegate as!
        AppDelegate).memes
      println("memes: \(memes[0].text_bottom)")
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
    return true
  }
  func textFieldDidBeginEditing(textField: UITextField) {

  }
  
  func generateMemedImage() -> UIImage {
    
    // TODO: Hide toolbar and navbar
    self.toolBar.hidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    self.view.drawViewHierarchyInRect(self.view.frame,
      afterScreenUpdates: true)
    let memedImage : UIImage =
    UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.toolBar.hidden = false
    
    // TODO:  Show toolbar and navbar
    
    return memedImage
  }
  
  func save() {
    //Create the meme
    let memedImage = generateMemedImage()
    var meme = Meme( text_top: self.top.text, text_bottom: self.bottom.text, image:
      imagePickerView.image!, memedImage: memedImage)
    (UIApplication.sharedApplication().delegate as!
      AppDelegate).memes.append(meme)
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

