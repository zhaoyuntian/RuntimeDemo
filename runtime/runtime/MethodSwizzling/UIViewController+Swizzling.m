//
//  UIViewController+Swizzling.m
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation UIViewController (Swizzling)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillAppear:) bySwizzledSelector:@selector(swizzl_viewWillAppear:)];
    });
}

- (void)swizzl_viewWillAppear:(BOOL)animated {
    [self swizzl_viewWillAppear:animated];

#pragma mark  应用实例 #1日志添加 #2事件统计 #3控制器加载时间
    NSLog(@"viewWillAppear:%@",NSStringFromClass(self.class));
}
@end
