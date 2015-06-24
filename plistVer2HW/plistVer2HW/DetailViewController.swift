//  DetailViewController.swift
//  plistVer2HW
//
//  Created by Richard H Woolley on 6/22/15.
//  Copyright (c) 2015 Bright Quasar Software, R.Woolley.

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var imageView: UIImageView!


  @IBOutlet weak var cameraMissingAlert: UILabel!

  var selectedPerson : Person!  // we know we will "initialize" this through helper func in viewDidLoad()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTextFields()  // encapsulate via a private helper func
  }

  private func setupTextFields() {
    self.firstNameTextField.delegate = self
    self.lastNameTextField.delegate = self
    self.firstNameTextField.tag = 0
    self.lastNameTextField.tag = 1
    //self.firstNameTextField.text = self.selectedPerson.firstName // I commented-out these two lines, as I use place holder text
    //self.lastNameTextField.text = self.selectedPerson.lastName
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()  // dismiss keyboard
    //return false  // could return true
    return true
  }


  func textFieldDidEndEditing(textField: UITextField) {  // use more-clear switch to asign per tags
    switch textField.tag {
    case 0:
      self.selectedPerson.firstName = textField.text
    case 1:
      self.selectedPerson.lastName = textField.text
    default:
      break
    }
  }

  @IBAction func photoButtonPressed(sender: AnyObject) {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
    imagePickerController.allowsEditing = true
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      self.presentViewController(imagePickerController, animated: true, completion: nil)
    } else {
      // Warn the user of the missing camera in both the sim and the really-old-iPod-touch
      self.cameraMissingAlert.text = "No camera found"
    }
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {  // added optional binding 
      self.imageView.image = image
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  }
}
