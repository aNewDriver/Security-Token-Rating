//
//  Header.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/18.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WKPostCategary) {
    WKPostCategary_unDefine = 0, //!< 未定义的, 不取
    WKPostCategary_projectDis = 2, //!< 项目讨论区
    WKPostCategary_topicDis = 3, //!< 话题讨论区
    WKPostCategary_project = 4, //!< 所有项目
    WKPostCategary_news = 5, //!< 资讯
    WKPostCategary_issuedProject = 6, //!< 已发布的项目
    WKPostCategary_unIssuedProject = 7 //!< 未发布的项目
};

typedef NS_ENUM(NSUInteger, WKRefreshType) {
    WKRefreshType_refresh = 1, //!< 刷新
    WKRefreshType_loadMore = 2 //!< 加载更多
};

static NSString *const SpicalTextName = @"SFProText-Medium"; //!< 特殊字体名字
static NSString *const DINTextName = @"DIN-Medium"; //!< DIN字体
static NSString *const DetailSpicalTextName = @"SFProText-Regular";

static NSString *const LoginInfoModelKey = @"LoginInfoModelKey";


//@"http://10.3.9.116:8080/index.php/wp-json/"
static NSString *const BASEURL = @"https://app.securitytokenratings.info/wp-json/";

#pragma mark - 首页

static NSString *const HomeProjectListUrl = @"wp/v2/posts"; //!< 项目列表
static NSString *const ProjectCommentsUrl = @"wp/v2/comments"; //!< 项目评论


#pragma mark - 注册登录
static NSString *const RegisterUrl = @"wp/v2/users/register"; //!< 注册 POST
static NSString *const LoginUrl = @"jwt-auth/v1/token"; //!< 登陆 POST

static NSString *const GetUserInfoUrl = @"wp/v2/users/"; //!< 获取用户信息 GET


#pragma mark - 评论

static NSString *const CommentURL = @"wp/v2/comments"; //!< 评论 POST


#endif /* Header_h */
