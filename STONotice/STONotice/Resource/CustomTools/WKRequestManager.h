//
//  WKRequestManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WKHTTPRequestMethodType) {
    WKHTTPRequestMethodTypeGET = 1,
    WKHTTPRequestMethodTypePOST = 2
};

NS_ASSUME_NONNULL_BEGIN

@interface WKRequestManager : NSObject


/**
 请求方法

 @param URLString URL
 @param parameters params
 @param type 请求方法 GET/POST
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(WKHTTPRequestMethodType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
