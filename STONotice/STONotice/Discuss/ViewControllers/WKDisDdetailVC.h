//
//  WKDisDdetailVC.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKBaseDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKDisDdetailVC : WKBaseDetailViewController

- (instancetype)initWithNeedRightButton:(BOOL)needRightButton model:(WKPostInfoModel *)model isTopicDis:(BOOL)isTopicDis;

@end

NS_ASSUME_NONNULL_END
