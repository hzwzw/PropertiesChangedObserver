//
//  ViewController.swift
//  PropertiesChangedObserver
//
//  Created by wangzhiwei on 6/27/15.
//  Copyright (c) 2015 hzwzw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var lastNameField: UITextField!
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var stateField: UITextField!
  @IBOutlet weak var cityField: UITextField!
  @IBOutlet weak var apartmentField: UITextField!
  @IBOutlet weak var streetField: UITextField!
  
  var address = AddressModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.readFromModel()
    address.isModified = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func detcetIfPropertyChanged(sender: AnyObject) {
    for i in 100...104 {
      let field = self.view.viewWithTag(i) as? UITextField
      if field?.checkNull() == true {
        // alert and return 
        return
      }
    }
    self.writeToModel()
    var str = address.isModified ? "Some properties have changed": "nothing changed"
    let alertController = UIAlertController(title: "Nice", message: str, preferredStyle: UIAlertControllerStyle.Alert)
    let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
    alertController.addAction(cancelAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    address.isModified = false
  }
  
  private func readFromModel() {
    lastNameField.text = address.lastName
    firstNameField.text = address.firstName
    stateField.text = address.state
    cityField.text = address.city
    apartmentField.text = address.apartMent
    streetField.text = address.street
  }
  
  private func writeToModel() {
    address.lastName = lastNameField.text
    address.firstName = firstNameField.text
    address.street = streetField.text
    address.apartMent = apartmentField.text
    address.city = cityField.text
  }
}



