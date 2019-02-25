//
//  WKLoginInfoManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/23.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKLoginInfoManager.h"

static WKLoginInfoManager *manager = nil;

@implementation WKLoginInfoManager

+ (instancetype)sharedInsetance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WKLoginInfoManager alloc] init];
    });
    return manager;
}


- (void)persistenceLoginInfoWithResponse:(NSDictionary * _Nonnull )response {
    
    //!< 先取出存储的信息, 并更新数据
    
    WKLoginRegiserInfoModel *loginInfo = [self getLoginInfo];
   
    if (response) {
        loginInfo.token = response[@"token"];
        loginInfo.user_display_name = response[@"user_display_name"];
        loginInfo.user_email = response[@"user_email"];
        loginInfo.user_nicename = response[@"user_nicename"];
    }
    //!< 同步
    NSData *resultData ;
    if (@available(iOS 11.0, *)) {
        resultData = [NSKeyedArchiver archivedDataWithRootObject:loginInfo requiringSecureCoding:NO error:nil];
        
    } else {
        resultData = [NSKeyedArchiver archivedDataWithRootObject:loginInfo];

    }
    if (resultData) {
        [[NSUserDefaults standardUserDefaults] setObject:resultData forKey:LoginInfoModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


- (WKLoginRegiserInfoModel *)getLoginInfo {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:LoginInfoModelKey];
    WKLoginRegiserInfoModel *loginInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!loginInfo) { //!< 为空
        loginInfo = [[WKLoginRegiserInfoModel alloc] init];
    }
    return loginInfo;
}


- (void)logoutInfoModel {
    
    [MBProgressHUD showHUDAddedTo:[NSObject getTopviewControler].view animated:YES];
    
    [self performSelector:@selector(completeMethod) withObject:nil afterDelay:1.5f];
    
}

- (void)completeMethod {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:LoginInfoModelKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];
}

@end
