//
//  WKProjectDetailHeaderView.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProjectDetailHeaderView : UIView

@property (nonatomic, copy) void(^segmentClick)(NSUInteger index);

- (void)updateUIWithModel:(WKPostInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
