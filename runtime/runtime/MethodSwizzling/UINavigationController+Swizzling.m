//
//  UINavigationController+Swizzling.m
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

/*
 全局修改导航栏后退（返回）
 */

#import "UINavigationController+Swizzling.h"
#import "NSObject+Swizzling.h"
static char *kCustomBackButtonKey;
@implementation UINavigationController (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(backBarButtonItem)
                               bySwizzledSelector:@selector(sure_backBarButtonItem)];

    });
}

- (UIBarButtonItem*)sure_backBarButtonItem {
    UIBarButtonItem *backItem = [self sure_backBarButtonItem];
    if (backItem) {
        return backItem;
    }
    backItem = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!backItem) {
        backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, backItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backItem;
}
@end
