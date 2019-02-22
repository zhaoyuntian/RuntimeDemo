//
//  NSObject+Swizzling.h
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
