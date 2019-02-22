//
//  PlaceholderView.h
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceholderView : UIView
@property (nonatomic, copy) void(^reloadClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
