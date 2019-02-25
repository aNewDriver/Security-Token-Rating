//
//  WKHomeManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/18.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKHomeManager.h"
#import "WKRequestManager.h"
#import "WKRegisterManager.h"


@implementation WKHomeManager

+ (void)requestProjectsWithCurrentPage:(NSUInteger)currentPage
                               success:(void(^)(id response))success
                                  fail:(void(^)(NSError *error))fail {
    
    [WKRequestManager requestWithURLString:HomeProjectListUrl parameters:@{@"page" : @(currentPage), @"categories" : @[@(WKPostCategary_project)]} type:WKHTTPRequestMethodTypeGET success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


+(void)requestCommentsWithPostId:(NSString *)postId
                            page:(NSUInteger)page
                         success:(void(^)(id response))success
                            fail:(void(^)(NSError *error))fail  {
    if ([postId isEmpty]) {
        return;
    }

    [WKRequestManager requestWithURLString:ProjectCommentsUrl parameters:@{@"post":postId, @"page":@(page)} type:WKHTTPRequestMethodTypeGET success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


+ (void)getUserInfoWithUserId:(NSString *)userId
                      success:(void(^)(id response))success
                         fail:(void(^)(NSError *error))fail {
    if ([userId isEmpty]) {
        return;
    }
    
    [WKHomeManager loginIfNeededSuccess:^{
        
        NSString *realUrl = [GetUserInfoUrl stringByAppendingString:userId];
        [WKRequestManager requestWithoutHUDWithURLString:realUrl parameters:@{} type:WKHTTPRequestMethodTypeGET success:^(id  _Nonnull responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
    } fail:^(NSError *error) {
        
    }];
    
}

+ (void)loginIfNeededSuccess:(void(^)(void))success fail:(void(^)(NSError *error))fail {
    
    WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
    
    if (model.token != nil && ![model.token isEmpty]) {
        if (success) {
            success();
        }
        return;
    }
    
    NSDictionary *LoginParams = @{@"username":@"stadmin",
                                  @"password":@"Q62n%s2B7ue!T$@^fsy"};
    
    [WKRegisterManager LoginWithParams
     :LoginParams success:^(id  _Nonnull response) {
         
         NSDictionary *dic = (NSDictionary *)response;
         
         if ([dic.allKeys containsObject:@"token"]) {
             [[WKLoginInfoManager sharedInsetance] persistenceLoginInfoWithResponse:dic];
             if (success) {
                 success();
             }
         }
         
     } fail:^(id  _Nonnull error) {
         
         if (fail) {
             fail(error);
         }
         
     }];
}

@end
