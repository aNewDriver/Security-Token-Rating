//
//  WKRequestManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKRequestManager.h"
#import "AFHTTPSessionManager.h"



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
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
    if (model.token != nil && ![model.token isEmpty]) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", model.token] forHTTPHeaderField:@"Authorization"];
    }
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSString *realURLS = [BASEURL stringByAppendingString:URLString];
    NSLog(@"%@", realURLS);
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
                [[NSObject getTopviewControler].view makeToast:error.localizedDescription];
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
                UIView *view = [NSObject getTopviewControler].view;
                [view makeToast:error.localizedDescription duration:1.5f position:@(ToastCenter)];
            }];
        }
            break;
        default:
            break;
    }
}


+ (void)specialPostRequestWithURLString:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure {
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建
    NSURL *url = [NSURL URLWithString:[BASEURL stringByAppendingString:URLString]];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体//告诉服务器数据为json类型[POST
    [request setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //设置请求体(json类型)
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody= jsonData;

    //6.根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask*dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData* _Nullable data,NSURLResponse* _Nullable response,NSError* _Nullable error) {
        
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
        if (!error && success) {
            success(dict);
        } else if(error && failure){
            failure(error);
        }
        
    }];
    //7.执行任务
    [dataTask resume];
    
}


+ (void)requestWithoutHUDWithURLString:(NSString *)URLString
                            parameters:(id)parameters
                                  type:(WKHTTPRequestMethodType)type
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
    if (model.token != nil && ![model.token isEmpty]) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", model.token] forHTTPHeaderField:@"Authorization"];
    }
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSString *realURLS = [BASEURL stringByAppendingString:URLString];
    NSLog(@"%@", realURLS);
    switch (type) {
        case WKHTTPRequestMethodTypeGET:
        {
            
            [manager GET:realURLS parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
                if (success) {
                    id jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
                    success(jsons);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case WKHTTPRequestMethodTypePOST:
        {
           
            
            [manager POST:realURLS parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                if (success) {
                    id jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:nil];
                    success(jsons);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
            }];
        }
            break;
        default:
            break;
    }
}

@end
