//
//  NSString+WKAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "NSString+WKAdd.h"

@implementation NSString (WKAdd)

- (BOOL)isEmpty {
    if (!self || self == nil || [self isEqualToString:@"null"] || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"] || [self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

@end
