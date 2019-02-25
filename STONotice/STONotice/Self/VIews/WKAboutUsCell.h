//
//  WKAboutUsCell.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/29.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKAboutUsCell : UITableViewCell

- (void)configureUI:(NSString *)title detail:(NSString *)detail;

@property (nonatomic, copy) void(^tapClickCallBack)(void);


@end

NS_ASSUME_NONNULL_END
