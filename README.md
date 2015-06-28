# PropertiesChangedObserver
the super class used for observer if any property has changed

###Why we need this?
When we supply the function of Editing information to users, we'd better knowing if our users has changed some properties of the model. So we can decide if the "Save" button is enabled or presenting the alert to save it before she leaves viewController without saveing.  

There is some little trick helping you achieve this function without doing anything. It's so easy.

###demo:
[![alt tag][https://github.com/hzwzw/PropertiesChangedObserver/blob/master/doc/demo.gif]

###How to use it?
1. Inheriting the `PropertiesChangedObserver` class.
````
class AddressModel: HZPropertyChangedObsever {
  dynamic var lastName: String!
  dynamic var firstName: String!
}
````
2. Just check the property `isModified` whenever you want.
3. Remember set `isModified` to `false` after you detected it.


