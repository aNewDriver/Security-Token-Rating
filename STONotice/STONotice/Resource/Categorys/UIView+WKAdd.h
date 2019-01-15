//
//  UIView+WKAdd.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/15.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WKAdd)



/**
 给view添加阴影

 @param offset 偏移量
 @param radius 半径
 @param color 颜色
 @param opacity 透明度
 */
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

@end

NS_ASSUME_NONNULL_END
