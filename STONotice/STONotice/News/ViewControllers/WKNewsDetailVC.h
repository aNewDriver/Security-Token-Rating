//
//  WKNewsDetailVC.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKBaseDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKNewsDetailVC : WKBaseDetailViewController
@property (nonatomic, assign) BOOL formBanner;

- (instancetype)initWithModel:(WKPostInfoModel *)model;


@end

NS_ASSUME_NONNULL_END
