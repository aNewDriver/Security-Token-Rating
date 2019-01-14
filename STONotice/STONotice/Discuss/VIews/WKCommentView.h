//
//  WKCommentView.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

//!< 评论View


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKCommentView : UIView

@property (nonatomic, copy) void(^tapClicked)(void);

@end

NS_ASSUME_NONNULL_END
