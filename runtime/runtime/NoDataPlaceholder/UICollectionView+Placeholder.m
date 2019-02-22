//
//  UICollectionView+Placeholder.m
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import "UICollectionView+Placeholder.h"
#import "NSObject+Swizzling.h"
#import "PlaceholderView.h"
@implementation UICollectionView (Placeholder)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(sure_reloadData)];
    });
}

- (void)sure_reloadData {
    if (!self.firstReload) {//非首次刷新检测是否为空 解决数据加载未完成显示占位图情况
        [self checkEmpty];
    }
    self.firstReload = NO;
    [self sure_reloadData];
}

- (void)checkEmpty {
    BOOL isEmpty = YES;

    id <UICollectionViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self] - 1;
    }

    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource collectionView:self numberOfItemsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }

    if (isEmpty) {//若为空，加载占位图
                  //默认占位图
        if (!self.placeholderView) {
            [self makeDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    } else {//不为空，移除占位图
        self.placeholderView.hidden = YES;
    }
}

- (void)makeDefaultPlaceholderView {
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    PlaceholderView *placeholderView = [[PlaceholderView alloc]initWithFrame:self.bounds];
    __weak typeof(self) weakSelf = self;
    [placeholderView setReloadClickBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.reloadBlock) {
            strongSelf.reloadBlock();
        }
    }];
    self.placeholderView = placeholderView;
}

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
