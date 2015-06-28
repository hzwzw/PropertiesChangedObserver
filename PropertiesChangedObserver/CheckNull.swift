//
//  CheckNull.swift
//  PropertiesChangedObserver
//
//  Created by wangzhiwei on 6/27/15.
//  Copyright (c) 2015 hzwzw. All rights reserved.
//

import UIKit

extension UITextField {
  func checkNull() -> Bool {
    self.trim()
    if count(self.text) == 0 {
      return true
    }else {
      return false
    }
  }
  
  func trim() {
    var newString = self.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    self.text = newString
  }
}
