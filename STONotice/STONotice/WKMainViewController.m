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
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:homeLStr image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(16.0f)} forState:UIControlStateNormal];
    
    
    //!< newsVC
    WKNewsViewController *newsVC = [[WKNewsViewController alloc] init];
    UINavigationController *newsNAV = [[UINavigationController alloc] initWithRootViewController:newsVC];
    NSString *newsStr = WKGetStringWithKeyFromTable(@"newsTabberTitle", nil);
    newsVC.title = newsStr;
    
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首页" attributes:@{NSFontAttributeName : @16.0f}];
    
    newsNAV.tabBarItem = [[UITabBarItem alloc] initWithTitle:newsStr image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    [newsNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(16.0f)} forState:UIControlStateNormal];
    
    //!< discussVC
    WKDiscussViewController *disVC = [[WKDiscussViewController alloc] init];
    UINavigationController *disNAV = [[UINavigationController alloc] initWithRootViewController:disVC];
    
    // NSLocalizedString(@"discussTabberTitle", nil)
    NSString *disStr = WKGetStringWithKeyFromTable(@"discussTabberTitle", @"Localizable");
    disVC.title = disStr;
    
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首页" attributes:@{NSFontAttributeName : @16.0f}];
    
    disNAV.tabBarItem = [[UITabBarItem alloc] initWithTitle:disStr image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    [disNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(16.0f)} forState:UIControlStateNormal];
    
    //!< selfVC
    WKSelfViewController *selfVC = [[WKSelfViewController alloc] init];
    UINavigationController *selfNav = [[UINavigationController alloc] initWithRootViewController:selfVC];
    NSString *selfLStr = WKGetStringWithKeyFromTable(@"selfTabbarTitle", nil);
    selfVC.title = selfLStr;
    
     selfNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:selfLStr image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    [selfNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(16.0f)} forState:UIControlStateNormal];
    
    
    self.viewControllers = @[nav, newsNAV, disNAV, selfNav];
    
}


@end
