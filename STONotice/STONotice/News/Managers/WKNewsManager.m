//
//  WKNewsManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/21.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKNewsManager.h"

@implementation WKNewsManager


+ (void)requestNewsWithCurrentPage:(NSUInteger)currentPage
                           success:(void(^)(id response))success
                              fail:(void(^)(NSError *error))fail {
    
    [WKRequestManager requestWithURLString:HomeProjectListUrl parameters:@{@"page" : @(currentPage), @"categories" : @[@(WKPostCategary_news)]} type:WKHTTPRequestMethodTypeGET success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end
