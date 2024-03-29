//
//  WKProjectDiscussCell.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

//!< 横划cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProjectDiscussCell : UITableViewCell

@property (nonatomic, copy) void (^didSelecetedAtIndexPath)(NSIndexPath *indexPath);

@property (nonatomic, copy) NSArray <WKPostInfoModel *> *projectModelArray;




@end

NS_ASSUME_NONNULL_END
