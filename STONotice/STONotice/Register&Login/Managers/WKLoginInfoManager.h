//
//  WKLoginInfoManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/23.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKLoginInfoManager : NSObject

+ (instancetype)sharedInsetance;


/**
 取出登录信息

 @return 登录信息
 */
- (WKLoginRegiserInfoModel *)getLoginInfo;


/**
 持久化登录信息

 @param response void
 */
- (void)persistenceLoginInfoWithResponse:(NSDictionary * _Nonnull )response;


/**
 注销
 */
- (void)logoutInfoModel;

@end

NS_ASSUME_NONNULL_END
