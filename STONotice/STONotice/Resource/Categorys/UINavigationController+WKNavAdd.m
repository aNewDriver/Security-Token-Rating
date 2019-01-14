//
//  UINavigationController+WKNavAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "UINavigationController+WKNavAdd.h"

@implementation UINavigationController (WKNavAdd)

- (void)pushAndHiddenTabbarViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (!viewController) {
        return;
    }
    
    //1. 取出分栏
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    if (!tabBar) {
        [self performSelector:@selector(pushViewController:animated:) withObject:viewController];
    }
    // 将frame左移分栏的宽度
    CGRect frame = tabBar.frame;
    frame.origin.x -= tabBar.frame.size.width;
    
    // 动画影藏tabBar
    [UIView animateWithDuration:0.28 animations:^{
        tabBar.frame = frame;
    }];
    
    [self pushViewController:viewController animated:animated];
}

- (UIViewController *)popAndHiddenTabbarViewControllerAnimated:(BOOL)animated
{
    //1. 取出分栏
    UITabBar *tabBar = self.tabBarController.tabBar;
    // 将frame左移分栏的宽度
    CGRect frame = tabBar.frame;
    frame.origin.x += tabBar.frame.size.width;
    // 动画影藏tabBar
    [UIView animateWithDuration:0.28 animations:^{
        tabBar.frame = frame;
    }];
    return [self popViewControllerAnimated:YES];
}


@end
