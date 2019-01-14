//
//  WKRequestManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKRequestManager.h"
#import "AFHTTPSessionManager.h"


static NSString *const BASEURL = @"http://10.3.9.116:8080/index.php/wp-json/";

@interface WKRequestManager ()

@end

@implementation WKRequestManager

+ (instancetype)sharedManager {
    static WKRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WKRequestManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        //!< 设置cookie和header
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 位置网络
                    NSLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    NSLog(@"无法联网");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // 手机自带网络
                    NSLog(@"当前使用的是2G/3G/4G网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    // WIFI
                    NSLog(@"当前在WIFI网络下");
                }
            }
        }];
    }
    return self;
}


#pragma mark - method

+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(WKHTTPRequestMethodType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSString *realURLS = [BASEURL stringByAppendingString:URLString];
    [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];
    switch (type) {
        case WKHTTPRequestMethodTypeGET:
        {
            [MBProgressHUD showHUDAddedTo:[NSObject getTopviewControler].view animated:YES];
            [manager GET:realURLS parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];

                if (success) {
                    id jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
                    success(jsons);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];
                if (failure) {
                    failure(error);
                }
                [[NSObject getTopviewControler].view makeToast:error.description];
            }];
        }
            break;
        case WKHTTPRequestMethodTypePOST:
        {
            [MBProgressHUD showHUDAddedTo:[NSObject getTopviewControler].view animated:YES];

            [manager POST:realURLS parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];

                if (success) {
                    id jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
                    success(jsons);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];
                if (failure) {
                    failure(error);
                }
                [[NSObject getTopviewControler].view makeToast:error.description];
            }];
        }
            break;
        default:
            break;
    }
}

@end
