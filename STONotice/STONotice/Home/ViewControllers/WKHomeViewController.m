//
//  WKHomeViewController.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKHomeViewController.h"
#import "WKRegisterVC.h"
#import "WKLoginVC.h"
#import "SDCycleScrollView.h"
#import "WKProjectDetailVC.h"
#import "WKProjectCell.h"


@interface WKHomeViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *mainTV;

@end

@implementation WKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
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

- (void)baseConfigure {
//    self.view.backgroundColor = [UIColor redColor];
    [self configureBackImage];
    [self.view addSubview:self.mainTV];
    self.mainTV.tableHeaderView = [self headerView];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(self.view).offset(-50.0f);
    }];
}

- (void)configureBackImage {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0f)];
    imageV.image = [UIImage imageNamed:@"backImage"];
    [self.view addSubview:imageV];
}

- (UIView *)headerView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 105.0f);
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.font = SYSTEM_NORMAL_FONT(21.0f);
    label.text = @"The first STO information \n platform is online";
    [view addSubview:label];
    
    return view;
}


#pragma mark - delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    WKProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKProjectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKProjectDetailVC *detailVC = [[WKProjectDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0f)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 15, 30.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBCOLOR(98, 98, 108);
    label.font = SYSTEM_NORMAL_FONT(14.0f);
    NSString *str = @"";
    if (section == 1) {
        str = @"Unreleased";
    }
    label.text = str;
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001f;
    }
    return 40.0f;
}



#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTV;
}

@end
