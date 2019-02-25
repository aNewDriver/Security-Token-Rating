//
//  WKDiscussManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/21.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKDiscussManager.h"

@implementation WKDiscussManager

+ (void)requestProjectCommunityListWithCurrentPage:(NSUInteger)currentPage
                                           success:(void(^)(id response))success
                                              fail:(void(^)(NSError *error))fail {
    
    [WKRequestManager requestWithURLString:HomeProjectListUrl parameters:@{@"page" : @(currentPage), @"categories" : @[@(WKPostCategary_projectDis)]} type:WKHTTPRequestMethodTypeGET success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)requestTopicCommunityListWithCurrentPage:(NSUInteger)currentPage
                                           success:(void(^)(id response))success
                                              fail:(void(^)(NSError *error))fail {
    
    [WKRequestManager requestWithURLString:HomeProjectListUrl parameters:@{@"page" : @(currentPage), @"categories" : @[@(WKPostCategary_topicDis)]} type:WKHTTPRequestMethodTypeGET success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)commentProjectWithPostId:(NSString *)postId
                         content:(NSString *)content
                         success:(void(^)(id response))success
                            fail:(void(^)(NSError *error))fail {
    
    
    
    [WKRequestManager requestWithoutHUDWithURLString:CommentURL parameters:@{@"post" : postId, @"content" : content} type:WKHTTPRequestMethodTypePOST success:^(id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:[NSObject getTopviewControler].view animated:YES];
        if (fail) {
            fail(error);
        }
        UIView *view = [NSObject getTopviewControler].view;
        NSString *errM = error.localizedDescription;
        if ([errM containsString:@"conflict"]) {
            [view makeToast:WKGetStringWithKeyFromTable(@"commentConfilct", nil) duration:1.5f position:@(ToastCenter)];
        } else {
            [view makeToast:errM duration:1.5f position:@(CGPointMake(SCREEN_WIDTH / 2, 200))];
        }
        
    }];
}

@end
