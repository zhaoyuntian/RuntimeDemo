//
//  UnicodeInputChinese.m
//  runtime
//
//  Created by tanma on 2019/9/3.
//  Copyright © 2019 zhaoyuntian. All rights reserved.
//

#import "UnicodeInputChinese.h"
#import <objc/runtime.h>

//控制台Unicode 转中文

static inline void ZYTswizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (UnicodeInputChinese)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];

    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (UnicodeInputChinese)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ZYTswizzleSelector(class, @selector(description), @selector(ZYTdescription));
        ZYTswizzleSelector(class, @selector(descriptionWithLocale:), @selector(ZYTdescriptionWithLocale:));
        ZYTswizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(ZYTdescriptionWithLocale:indent:));
    });
}

/**
 *  我觉得
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)ZYTdescription {
    return [[self ZYTdescription] stringByReplaceUnicode];
}

- (NSString *)ZYTdescriptionWithLocale:(nullable id)locale {
    return [[self ZYTdescriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)ZYTdescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self ZYTdescriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (UnicodeInputChinese)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ZYTswizzleSelector(class, @selector(description), @selector(ZYTdescription));
        ZYTswizzleSelector(class, @selector(descriptionWithLocale:), @selector(ZYTdescriptionWithLocale:));
        ZYTswizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(ZYTdescriptionWithLocale:indent:));
    });
}

- (NSString *)ZYTdescription {
    return [[self ZYTdescription] stringByReplaceUnicode];
}

- (NSString *)ZYTdescriptionWithLocale:(nullable id)locale {
    return [[self ZYTdescriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)ZYTdescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self ZYTdescriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (UnicodeInputChinese)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ZYTswizzleSelector(class, @selector(description), @selector(ZYTdescription));
        ZYTswizzleSelector(class, @selector(descriptionWithLocale:), @selector(ZYTdescriptionWithLocale:));
        ZYTswizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(ZYTdescriptionWithLocale:indent:));
    });
}

- (NSString *)ZYTdescription {
    return [[self ZYTdescription] stringByReplaceUnicode];
}

- (NSString *)ZYTdescriptionWithLocale:(nullable id)locale {
    return [[self ZYTdescriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)ZYTdescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self ZYTdescriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
