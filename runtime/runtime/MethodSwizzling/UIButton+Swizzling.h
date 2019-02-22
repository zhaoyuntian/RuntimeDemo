//
//  UIButton+Swizzling.h
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define defaultInterval 1

@interface UIButton (Swizzling)
    //点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
    //用于设置单个按钮不需要被hook
@property (nonatomic, assign) BOOL isIgnore;
@end

NS_ASSUME_NONNULL_END
