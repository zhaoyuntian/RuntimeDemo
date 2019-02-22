//
//  NSObject+Extension.m
//  runtime
//
//  Created by tanma on 2019/2/22.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

/**简单的字典和模型的自动转换*/

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)
- (instancetype)initWithDict:(NSDictionary *)dic{

    if (self = [self init]) {
        //获取类的属性及属性对应的类型
        NSMutableArray * keys = [NSMutableArray array];
        NSMutableArray * attributes = [NSMutableArray array];

        unsigned int outCount;
        objc_property_t * properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            objc_property_t property = properties[i];
            //通过property_getName函数获得属性的名字
            NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
            //通过property_getAttributes函数可以获得属性的名字和@encode编码
            NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [attributes addObject:propertyAttribute];
        }
        //立即释放properties指向的内存
        free(properties);

        //根据类型给属性赋值
        for (NSString * key in keys) {
            if ([dic valueForKey:key] == nil) continue;
            [self setValue:[dic valueForKey:key] forKey:key];
        }
    }
    return self;

}

@end
