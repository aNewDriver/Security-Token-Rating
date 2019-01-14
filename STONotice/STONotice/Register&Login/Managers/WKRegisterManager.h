//
//  WKRegisterManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKRegisterManager : NSObject

+ (void)registerNewUserWithUrlString:(nonnull NSString *)UrlString
                              params:(nonnull NSDictionary *)params
                             success:(void (^)(id response))success
                                fail:(void(^)(id error))fail;

@end

NS_ASSUME_NONNULL_END
