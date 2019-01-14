//
//  UIViewController+WKAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "UIViewController+WKAdd.h"

@implementation UIViewController (WKAdd)

- (CGFloat)getNavgationHeight {

    if (@available(iOS 11.0, *)) {
        if (!UIEdgeInsetsEqualToEdgeInsets(self.view.safeAreaInsets, UIEdgeInsetsZero)) {
        
            return 88.0f;
        }
    }
    return 64.0f;
}

- (BOOL)isLiuHaiScreen {
    BOOL isLiuHaiScreen = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return isLiuHaiScreen;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isLiuHaiScreen = YES;
        }
    }
    return isLiuHaiScreen;
}


@end
