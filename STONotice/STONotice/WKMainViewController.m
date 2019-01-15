//
//  WKMainViewController.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKMainViewController.h"
#import "WKHomeViewController.h"
#import "WKSelfViewController.h"
#import "WKDiscussViewController.h" //!< 讨论
#import "WKNewsViewController.h" //!< 资讯

@interface WKMainViewController ()

@end

@implementation WKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubVC];
}


- (void)addSubVC {
    
    //!< homeVC
    WKHomeViewController *homeVC = [[WKHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    NSString *homeLStr = WKGetStringWithKeyFromTable(@"homeTabbarTitle", nil);
    homeVC.title = homeLStr;
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:homeLStr image:[UIImage imageNamed:@"project"] selectedImage:[UIImage imageNamed:@"projectSelected"]];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    
    
    //!< newsVC
    WKNewsViewController *newsVC = [[WKNewsViewController alloc] init];
    UINavigationController *newsNAV = [[UINavigationController alloc] initWithRootViewController:newsVC];
    NSString *newsStr = WKGetStringWithKeyFromTable(@"newsTabberTitle", nil);
    newsVC.title = newsStr;
    
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首页" attributes:@{NSFontAttributeName : @16.0f}];
    
    newsNAV.tabBarItem = [[UITabBarItem alloc] initWithTitle:newsStr image:[UIImage imageNamed:@"news"] selectedImage:[UIImage imageNamed:@"newsSelected"]];
    [newsNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [newsNAV.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    
    //!< discussVC
    WKDiscussViewController *disVC = [[WKDiscussViewController alloc] init];
    UINavigationController *disNAV = [[UINavigationController alloc] initWithRootViewController:disVC];
    
    // NSLocalizedString(@"discussTabberTitle", nil)
    NSString *disStr = WKGetStringWithKeyFromTable(@"discussTabberTitle", @"Localizable");
    disVC.title = disStr;
    
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首页" attributes:@{NSFontAttributeName : @16.0f}];
    
    disNAV.tabBarItem = [[UITabBarItem alloc] initWithTitle:disStr image:[UIImage imageNamed:@"community"] selectedImage:[UIImage imageNamed:@"communitySelected"]];
    [disNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [disNAV.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    
    //!< selfVC
    WKSelfViewController *selfVC = [[WKSelfViewController alloc] init];
    UINavigationController *selfNav = [[UINavigationController alloc] initWithRootViewController:selfVC];
    NSString *selfLStr = WKGetStringWithKeyFromTable(@"selfTabbarTitle", nil);
    selfVC.title = selfLStr;
    
     selfNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:selfLStr image:[UIImage imageNamed:@"self"] selectedImage:[UIImage imageNamed:@"selfSelected"]];
    [selfNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [selfNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    
    
    self.viewControllers = @[nav, newsNAV, disNAV, selfNav];
    
}


@end
