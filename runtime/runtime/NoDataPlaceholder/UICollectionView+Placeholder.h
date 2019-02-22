//
//  UICollectionView+Placeholder.h
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Placeholder)
@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, copy) void(^reloadBlock)(void);
@end

NS_ASSUME_NONNULL_END
