//
//  WKSetLanagueCell.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKSetLanagueCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)updateCellWithDic:(nonnull NSDictionary *)dic;

- (void)didSelected;

- (void)didDeselected;

@end

NS_ASSUME_NONNULL_END
