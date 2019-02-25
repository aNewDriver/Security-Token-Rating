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
    [self dealBlackLine];
    // Do any additional setup after loading the view.
    [self addSubVC];
    [self getAllFonts];
}

- (void)dealBlackLine {
    
//    self.tabBar.backgroundColor = [UIColor whiteColor];
    UIColor *color = RGBCOLOR(244, 244, 244);
    UIImage *image = [color createImageWithSize:CGSizeMake(SCREEN_WIDTH, 0.5)];
    [self.tabBar setShadowImage:image];
    [self.tabBar setBackgroundImage:[[UIColor whiteColor] createImageWithSize:self.tabBar.size]];
}

- (void)getAllFonts {
    
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            printf( "\tFontName: %s \n", [fontName UTF8String] );
        }
    }
    
}


- (void)addSubVC {
    
    //!< homeVC
    WKHomeViewController *homeVC = [[WKHomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    NSString *homeLStr = WKGetStringWithKeyFromTable(@"homeTabbarTitle", nil);
    homeVC.title = homeLStr;
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:homeLStr image:[UIImage imageNamed:@"project"] selectedImage:[UIImage imageNamed:@"projectSelected"]];
//    UIFont *Font = SYSTEM_NORMAL_NAME_FONT(SpicalTextName, 10.0f);
//    NSArray *array =  [UIFont familyNames];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f),NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)];

    
    
    //!< newsVC
    WKNewsViewController *newsVC = [[WKNewsViewController alloc] init];
    UINavigationController *newsNAV = [[UINavigationController alloc] initWithRootViewController:newsVC];
    NSString *newsStr = WKGetStringWithKeyFromTable(@"newsTabberTitle", nil);
    newsVC.title = newsStr;
    
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首页" attributes:@{NSFontAttributeName : @16.0f}];
    
    newsNAV.tabBarItem = [[UITabBarItem alloc] initWithTitle:newsStr image:[UIImage imageNamed:@"news"] selectedImage:[UIImage imageNamed:@"newsSelected"]];
    [newsNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [newsNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    [newsNAV.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)];

    
    //!< discussVC
    WKDiscussViewController *disVC = [[WKDiscussViewController alloc] init];
    UINavigationController *disNAV = [[UINavigationController alloc] initWithRootViewController:disVC];
    
    // NSLocalizedString(@"discussTabberTitle", nil)
    NSString *disStr = WKGetStringWithKeyFromTable(@"discussTabberTitle", @"Localizable");
    disVC.title = disStr;
    
    //    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首页" attributes:@{NSFontAttributeName : @16.0f}];
    
    disNAV.tabBarItem = [[UITabBarItem alloc] initWithTitle:disStr image:[UIImage imageNamed:@"community"] selectedImage:[UIImage imageNamed:@"communitySelected"]];
    [disNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f),  NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [disNAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    [disNAV.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)];

    
    //!< selfVC
    WKSelfViewController *selfVC = [[WKSelfViewController alloc] init];
    UINavigationController *selfNav = [[UINavigationController alloc] initWithRootViewController:selfVC];
    NSString *selfLStr = WKGetStringWithKeyFromTable(@"selfTabbarTitle", nil);
//    selfVC.title = selfLStr;
    
     selfNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:selfLStr image:[UIImage imageNamed:@"self"] selectedImage:[UIImage imageNamed:@"selfSelected"]];
    [selfNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f),  NSForegroundColorAttributeName : RGBCOLOR(193, 193, 193)} forState:UIControlStateNormal];
    [selfNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : SPICAL_FONT(10.0f), NSForegroundColorAttributeName : RGBCOLOR(74, 143, 255)} forState:UIControlStateHighlighted];
    [selfNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,-3)]; //!< 设置字体上移
    selfVC.navigationController.navigationBar.hidden = YES;
    
    self.viewControllers = @[nav, newsNAV, disNAV, selfNav];
    
}


@end
