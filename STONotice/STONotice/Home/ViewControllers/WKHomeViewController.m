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

- (void)baseConfigure {
//    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(50.0f);
        make.height.equalTo(self.view).offset(-50.0f);
    }];
//    self.mainTV.tableHeaderView = [self createBannerView];
}

- (SDCycleScrollView *)createBannerView {
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) imageNamesGroup:@[@"", @"", @""]];
    bannerView.titlesGroup = @[@"123", @"345", @"456"];
    return bannerView;
}

#pragma mark - delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
