//
//  UIFont+Adjust.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/28.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "UIFont+Adjust.h"
#import <objc/runtime.h>


@implementation UIFont (Adjust)


+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat scale = screenW / 375.0f;
    newFont = [UIFont adjustFont:fontSize * scale];
    return newFont;
}

@end
