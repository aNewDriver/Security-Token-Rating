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

@class WKPostInfoTitleModel;

@interface WKPostInfoModel : NSObject

@property (nonatomic, copy) NSString *postId; //!< 资讯id
@property (nonatomic, copy) NSString *status; //!< 资讯状态, 是否公开
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *link; //!< 详情链接
@property (nonatomic, strong) WKPostInfoTitleModel *title; //!< title
@property (nonatomic, strong) WKPostInfoTitleModel *content; //!< 内容
@property (nonatomic, strong) WKPostInfoTitleModel *excerpt;
@property (nonatomic, copy) NSString *author; //!< 作者id

@end


@interface WKPostInfoTitleModel : NSObject

@property (nonatomic, strong) NSString *rendered; //!< 详情


@end

NS_ASSUME_NONNULL_END
