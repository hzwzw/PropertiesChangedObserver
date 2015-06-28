//
//  AddressModel.swift
//  PropertiesChangedObserver
//
//  Created by wangzhiwei on 6/27/15.
//  Copyright (c) 2015 hzwzw. All rights reserved.
//

import UIKit

class AddressModel: HZPropertyChangedObsever {
  dynamic var lastName: String!
  dynamic var firstName: String!
  dynamic var street: String!
  dynamic var apartMent: String?
  dynamic var city: String!
  dynamic var state: String!
  
  override init() {
    lastName = "wang"
    firstName = "hzwzw"
    street = "409 pierre rd"
    city = "city of industry"
    state = "California"
    apartMent = ""
  }
  
}
