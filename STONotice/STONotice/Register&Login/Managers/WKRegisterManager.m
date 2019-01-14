//
//  WKRegisterManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKRegisterManager.h"

@implementation WKRegisterManager

+ (void)registerNewUserWithUrlString:(nonnull NSString *)UrlString
                              params:(nonnull NSDictionary *)params
                             success:(void (^)(id response))success
                                 fail:(void(^)(id error))fail {
    [WKRequestManager requestWithURLString:UrlString
                                parameters:params
                                      type:WKHTTPRequestMethodTypePOST
                                   success:success
                                   failure:fail];
}

@end
