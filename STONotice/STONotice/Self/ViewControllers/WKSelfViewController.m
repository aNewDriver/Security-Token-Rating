//
//  WKSelfViewController.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSelfViewController.h"
#import "WKSelfCell.h"
#import "WKSetLanagueVC.h"
#import "WKSelfHeaderView.h"
#import "WKAboutUsVC.h"
#import "WKLoginVC.h"

@interface WKSelfViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, strong) WKSelfHeaderView *headerView;


@end

@implementation WKSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTV];
    self.mainTV.tableHeaderView = [self tabHeader];
   
    
    // Do any additional setup after loading the view.
}

- (void)updateDatasource {
    self.images = @[@"language", @"aboutUs", @"logout"];
    self.dataSource = @[WKGetStringWithKeyFromTable(@"displayLanguage", nil), WKGetStringWithKeyFromTable(@"aboutUs", nil)];
//    WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
//    if (model.token == nil) {
//
//    } else {
//        self.dataSource = @[WKGetStringWithKeyFromTable(@"displayLanguage", nil), WKGetStringWithKeyFromTable(@"aboutUs", nil), WKGetStringWithKeyFromTable(@"logOut", nil)];
//    }
    [self.mainTV reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.hidden = YES;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//隐藏
    
//    [self.headerView updateSelfInfo];
    [self updateDatasource];
    
//    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//隐藏
}


#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    WKSelfCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKSelfCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell configureUI:self.dataSource[indexPath.row]];
    [cell updateImageIconWithImageName:self.images[indexPath.row] hiddenRightItem:(indexPath.row == 2) ? YES : NO];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { //!< 选择语言
        WKSetLanagueVC *setVC = [[WKSetLanagueVC alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    } else if (indexPath.row == 1) { //!< 关于我们
        WKAboutUsVC *aboutVC = [[WKAboutUsVC alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    } else {
        WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
        if (model.token == nil) {
            return;
        }
        
        [[WKLoginInfoManager sharedInsetance] logoutInfoModel];
        [self performSelector:@selector(update) withObject:nil afterDelay:1.5f];
        

    }
}

- (void)update {
    
    [self.view makeToast:WKGetStringWithKeyFromTable(@"Logoutsuccess", nil) duration:1.0f position:@(ToastCenter)];
    [self.headerView updateSelfInfo];
    [self updateDatasource];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = BACKGROUND_COLOR;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.5f;
}



- (UIView *)tabHeader {
    CGFloat y = [self isLiuHaiScreen] ? 44.0f : 24;
    self.headerView = [[WKSelfHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76 + y)];
    
    self.headerView.tapClicked = ^{
        WKLoginVC *loginVC = [[WKLoginVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    };
    
    return self.headerView;
}

#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        CGFloat y = [self isLiuHaiScreen] ? -44.0f : -24;
        _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTV.backgroundColor = BACKGROUND_COLOR;
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTV;
}

@end
