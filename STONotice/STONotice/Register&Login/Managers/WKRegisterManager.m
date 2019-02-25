//
//  WKRegisterManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKRegisterManager.h"

@implementation WKRegisterManager

+ (void)registerNewUserWithParams:(nonnull NSDictionary *)params
                          success:(void (^)(id response))success
                             fail:(void(^)(id error))fail {
    
    if (!params) {
        return;
    }
    
    [WKRequestManager specialPostRequestWithURLString:RegisterUrl
                                           parameters:params
                                              success:success
                                              failure:fail];
   
    
}


+ (void)LoginWithParams:(nonnull NSDictionary *)params
                        success:(void (^)(id response))success
                           fail:(void(^)(id error))fail {
    
    if (!params) {
        return;
    }
    
    [WKRequestManager specialPostRequestWithURLString:LoginUrl
                                           parameters:params
                                              success:success
                                              failure:success];
}





@end
