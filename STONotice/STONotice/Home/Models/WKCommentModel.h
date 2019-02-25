//
//  WKCommentModel.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/21.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

//!< 评论model

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@class WKCommentAvatarURLModel;

@interface WKCommentModel : NSObject

@property (nonatomic, copy) NSString *commontId; //!< 评论id
@property (nonatomic, strong) WKPostInfoTitleModel *content; //!< 内容
@property (nonatomic, copy) NSString *author_name; //!< 评论人
@property (nonatomic, copy) NSString *date; //!< 评论时间
@property (nonatomic, copy) NSString *author; //!< 评论人id
@property (nonatomic, strong) WKCommentAvatarURLModel *author_avatar_urls; //!< URL
@property (nonatomic, strong) WKCommentAvatarURLModel *simple_local_avatar; //!< 真正头像URL

@end

@interface WKCommentAvatarURLModel : NSObject

@property (nonatomic, copy) NSString *media_id;
@property (nonatomic, copy) NSString *big;
@property (nonatomic, copy) NSString *middle;
@property (nonatomic, copy) NSString *little;
@property (nonatomic, copy) NSString *full;


@end

NS_ASSUME_NONNULL_END
