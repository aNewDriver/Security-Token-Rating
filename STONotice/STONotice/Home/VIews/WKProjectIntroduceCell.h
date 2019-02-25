//
//  WKProjectIntroduceCell.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

typedef enum {
    ProjectIntroduceCellType_noHaveName = 0,
    ProjectIntroduceCellType_haveName
}ProjectIntroduceCellType;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKProjectIntroduceCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
     ProjectIntroduceCellType:(ProjectIntroduceCellType)projectIntroduceCellType;

- (void)updateCellWithModel:(WKPostInfoModel *)model index:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
