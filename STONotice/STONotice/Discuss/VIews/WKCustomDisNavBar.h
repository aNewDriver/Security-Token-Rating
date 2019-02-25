//
//  WKCustomDisNavBar.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

//!< 自定义NAVBar

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKCustomDisNavBar : UIView

- (instancetype)initWithFrame:(CGRect)frame
                 navImageName:(NSString *)navImageName
                iconImageName:(NSString *)iconImageName
              needRightButton:(BOOL)needRightButton;

@property (nonatomic, copy) void(^goBack)(void);
@property (nonatomic, copy) void(^goToDetail)(void);



@end

NS_ASSUME_NONNULL_END
