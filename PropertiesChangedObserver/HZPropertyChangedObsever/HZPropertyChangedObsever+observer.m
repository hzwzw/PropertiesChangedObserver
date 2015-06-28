//
//  YMBNeedObserver+observer.m
//  Yamibuy
//
//  Created by wangzhiwei on 5/13/15.
//  Copyright (c) 2015 wangzhiwei. All rights reserved.
//

#import "HZPropertyChangedObsever+observer.h"
#import <objc/runtime.h>

IMP class_replaceMethodWithBlock(Class class, SEL originalSelector, id block);
IMP class_replaceMethodWithBlock(Class class, SEL originalSelector, id block) {
  IMP newImplementation = imp_implementationWithBlock(block);
  Method method = class_getInstanceMethod(class, originalSelector);
  return class_replaceMethod(class, originalSelector, newImplementation, method_getTypeEncoding(method));
}

@implementation HZPropertyChangedObsever (observer)

+ (NSSet *)keyPathsForValuesAffectingDummy {
  unsigned int num_props;
  objc_property_t * prop_list;
  prop_list = class_copyPropertyList(self, &num_props);
  
  NSMutableSet * propSet = [NSMutableSet set];
  for( unsigned int i = 0; i < num_props; i++ ){
    NSString * propName = [NSString stringWithFormat:@"%s", property_getName(prop_list[i])];
    if( [propName isEqualToString:@"isModified"] || [propName isEqualToString:@"dummy"]){
      continue;
    }
    [self modifyMethod: propName];
    [propSet addObject: propName];
  }
  free(prop_list);
  return propSet;
}

+ (BOOL)automaticallyNotifiesObserversForKey: (NSString *)key {
  return false;
}

+ (void)modifyMethod: (NSString* )getterName {
  NSString* setterName = [NSString stringWithFormat:@"set%@%@:",
                       [[getterName substringToIndex:1] uppercaseString],[getterName substringFromIndex:1]];
  SEL originalSelector = NSSelectorFromString(setterName);
  SEL getterSelector = NSSelectorFromString(getterName);
  
  __block IMP originalImp = NULL;
  void (^blockActualSwizzle)(id) = [^(id swizzedSelf, id value){
    IMP getterImp = [swizzedSelf methodForSelector: getterSelector];
    id oldValue = ((id (*)(id, SEL))getterImp)(swizzedSelf, getterSelector);
    BOOL isEqual = [value isEqual: oldValue];
    if (isEqual) {
      ((void(*)(id, SEL, id))originalImp)(swizzedSelf, originalSelector, value);
    }else {
      [swizzedSelf willChangeValueForKey: getterName];
      ((void(*)(id, SEL, id))originalImp)(swizzedSelf, originalSelector, value);
      [swizzedSelf didChangeValueForKey: getterName];
    }
  } copy];
  originalImp = class_replaceMethodWithBlock(self, originalSelector, blockActualSwizzle);
}

@end
