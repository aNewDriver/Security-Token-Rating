//
//  UIViewController+WKAdd.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WKAdd)


/**
 判断是否是刘海屏并返回NAV高度

 @return NAVheight
 */
- (CGFloat)getNavgationHeight;

- (BOOL)isLiuHaiScreen;

@end

NS_ASSUME_NONNULL_END
