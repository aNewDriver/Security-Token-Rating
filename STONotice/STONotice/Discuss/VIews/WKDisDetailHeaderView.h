//
//  WKDisDetailHeaderView.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKDisDetailHeaderView : UIView

- (void)updateUIWithModel:(WKPostInfoModel *)model isTopicDis:(BOOL)isTopicDis;

@end

NS_ASSUME_NONNULL_END
