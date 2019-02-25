//
//  WKNewsManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/21.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKNewsManager : NSObject


/**
 请求newList

 @param currentPage 当前页码
 @param success 成功
 @param fail 失败
 */
+ (void)requestNewsWithCurrentPage:(NSUInteger)currentPage
                           success:(void(^)(id response))success
                              fail:(void(^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
