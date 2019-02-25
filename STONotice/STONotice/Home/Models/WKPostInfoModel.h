//
//  WKPostInfoModel.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//!< 资讯列表model

NS_ASSUME_NONNULL_BEGIN

@class WKPostInfoTitleModel, WKProjectTeamMember, WKProjectDetailIofo, WKDiscussModel;

@interface WKPostInfoModel : NSObject

@property (nonatomic, assign) BOOL haveLoad; //!< 数据y是否已装载

@property (nonatomic, copy) NSString *postId; //!< 资讯id
@property (nonatomic, copy) NSString *status; //!< 资讯状态, 是否公开
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *link; //!< 详情链接
@property (nonatomic, strong) WKPostInfoTitleModel *title; //!< title
@property (nonatomic, strong) WKPostInfoTitleModel *content; //!< 内容
@property (nonatomic, strong) WKPostInfoTitleModel *excerpt;
@property (nonatomic, copy) NSString *author; //!< 作者id
@property (nonatomic, copy) NSArray <NSNumber *> *categories; //!< 分类
@property (nonatomic, copy) NSArray *resultContentArray; //!< 分割完字符串后得到的真实内容

@property (nonatomic, strong) WKProjectDetailIofo *detailModel; //!< 详情Model

@property (nonatomic, strong) WKDiscussModel *disscussModel; //!< 讨论区Model


@end


@interface WKPostInfoTitleModel : NSObject

@property (nonatomic, strong) NSString *rendered; //!< 详情

@end


@interface WKProjectDetailIofo : NSObject

@property (nonatomic, copy) NSString *price; //!< 价格
@property (nonatomic, copy) NSString *imageUrl; //!< 头像
@property (nonatomic, copy) NSArray <NSString *> *tags; //!< 项目标签
@property (nonatomic, copy) NSArray <NSString *> *categories; //!< 详情分类
@property (nonatomic, copy) NSArray <NSString *> *summarys; //!< 描述信息
@property (nonatomic, copy) NSString *projectSummary; //!< 项目描述
@property (nonatomic, strong) NSMutableArray <WKProjectTeamMember *>*teamMember; //!< 团队成员

@end

@interface WKProjectTeamMember : NSObject

@property (nonatomic, copy) NSString *name; //!< 姓名
@property (nonatomic, copy) NSString *linkUrl; //!< 领英URL
@property (nonatomic, copy) NSString *desc; //!< 描述

@end

//!< 讨论区model
@interface WKDiscussModel : NSObject

@property (nonatomic, copy) NSString *backIconUrl; //!< 背景icon
@property (nonatomic, copy) NSString *iconUrl; //!< icon
@property (nonatomic, copy) NSString *titleStr; //!< title
@property (nonatomic, copy) NSString *detailStr;


@end



NS_ASSUME_NONNULL_END
