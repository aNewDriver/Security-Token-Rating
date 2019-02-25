//
//  WKHomeManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/18.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKHomeManager : NSObject


/**
 获取项目列表

 @param currentPage 当前页码
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)requestProjectsWithCurrentPage:(NSUInteger)currentPage
                               success:(void(^)(id response))success
                                  fail:(void(^)(NSError *error))fail;


/**
 请求项目评论详情

 @param postId 项目id
 @param page 当前页码
 @param success 成功回调
 @param fail 失败回调
 */
+(void)requestCommentsWithPostId:(NSString *)postId
                            page:(NSUInteger)page
                         success:(void(^)(id response))success
                            fail:(void(^)(NSError *error))fail;

+ (void)getUserInfoWithUserId:(NSString *)userId
                      success:(void(^)(id response))success
                         fail:(void(^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
