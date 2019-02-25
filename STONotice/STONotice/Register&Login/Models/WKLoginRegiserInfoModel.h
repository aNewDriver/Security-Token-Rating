//
//  WKLoginRegiserInfoModel.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/23.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKLoginRegiserInfoModel : NSObject

@property (nonatomic, copy) NSString *token; //!< 登录后获取的token, 用于发表评论
@property (nonatomic, copy) NSString *user_display_name; //!< 用户昵称, 于显示
@property (nonatomic, copy) NSString *user_email; //!< 邮箱
@property (nonatomic, copy) NSString *user_nicename; //!< 登录名

@end

NS_ASSUME_NONNULL_END
