//
//  YMBNeedObserver.m
//  Yamibuy
//
//  Created by wangzhiwei on 5/13/15.
//  Copyright (c) 2015 wangzhiwei. All rights reserved.
//

#import "HZPropertyChangedObsever.h"

@interface HZPropertyChangedObsever() {
  FBKVOController *_KVOController;
}
@property(nonatomic, assign) BOOL dummy;
@end

@implementation HZPropertyChangedObsever

- (instancetype)init {
  self = [super init];
  if (self) {
    _KVOController = [[FBKVOController alloc] initWithObserver: self retainObserved: false];
    [_KVOController observe: self
                    keyPath: @"dummy"
                    options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block: ^(id observer, HZPropertyChangedObsever *object, NSDictionary *change) {
                      object.isModified = true;
    }];
  }
  return self;
}

@end
