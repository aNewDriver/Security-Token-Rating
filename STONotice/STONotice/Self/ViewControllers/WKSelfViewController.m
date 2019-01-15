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

@interface WKSelfViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *images;

@end

@implementation WKSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTV];
    self.mainTV.tableHeaderView = [self tabHeader];
    self.dataSource = @[@"Display Language", @"About Us", @"Log Out"];
    self.images = @[@"language", @"aboutUs", @"logout"];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//隐藏
//    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//隐藏
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
    [cell updateImageIconWithImageName:self.images[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { //!< 选择语言
        WKSetLanagueVC *setVC = [[WKSetLanagueVC alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    } else if (indexPath.row == 1) { //!< 关于我们
        
    } else {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
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
    WKSelfHeaderView *view = [[WKSelfHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120 + y)];
    return view;
}

#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        CGFloat y = [self isLiuHaiScreen] ? -44.0f : -24;
        _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTV;
}

@end
