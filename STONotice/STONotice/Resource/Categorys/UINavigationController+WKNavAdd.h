//
//  UINavigationController+WKNavAdd.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (WKNavAdd)

- (void)pushAndHiddenTabbarViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (UIViewController *)popAndHiddenTabbarViewControllerAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
