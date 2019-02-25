//
//  WKDiscussManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/21.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKDiscussManager : NSObject


/**
 项目讨论区列表

 @param currentPage 当前页码
 @param success 成功
 @param fail 失败
 */
+ (void)requestProjectCommunityListWithCurrentPage:(NSUInteger)currentPage
                                           success:(void(^)(id response))success
                                              fail:(void(^)(NSError *error))fail;


/**
 话题讨论区

 @param currentPage 当前页码
 @param success 成功
 @param fail 失败
 */
+ (void)requestTopicCommunityListWithCurrentPage:(NSUInteger)currentPage
                                         success:(void(^)(id response))success
                                            fail:(void(^)(NSError *error))fail;


/**
 评论

 @param postId postId
 @param content 内容
 @param success 成功
 @param fail 失败
 */
+ (void)commentProjectWithPostId:(NSString *)postId
                         content:(NSString *)content
                         success:(void(^)(id response))success
                            fail:(void(^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
