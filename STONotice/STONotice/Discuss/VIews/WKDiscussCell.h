//
//  WKDiscussCell.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKDiscussCell : UITableViewCell

- (void)updateCellWithModel:(WKCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
