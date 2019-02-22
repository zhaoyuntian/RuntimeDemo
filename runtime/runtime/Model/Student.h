//
//  Student.h
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger  sId; /**id*/
@property (nonatomic,copy) NSString * name; /**名字*/
@property (nonatomic,copy) NSString * address; /**住址*/
@end

NS_ASSUME_NONNULL_END
