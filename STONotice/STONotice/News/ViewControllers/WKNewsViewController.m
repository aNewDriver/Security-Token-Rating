//
//  WKNewsViewController.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKNewsViewController.h"
#import "SDCycleScrollView.h"
#import "WKNewCell.h"


@interface WKNewsViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *mainTV;

@end

@implementation WKNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.height.equalTo(self.view);
    }];
    self.mainTV.tableHeaderView = [self createBannerView];
}

- (UIView *)createBannerView {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(15, 12, SCREEN_WIDTH - 30.0f, 176)];
    shadowView.layer.cornerRadius = 5.0f;
    shadowView.layer.shadowOpacity = 1.0f;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    shadowView.layer.shadowColor = RGBCOLOR(0, 0, 0).CGColor;
    [view addSubview:shadowView];

    
    
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30.0f, 176) imageNamesGroup:@[@"", @"", @""]];
    bannerView.layer.cornerRadius = 5.0f;
    bannerView.layer.masksToBounds = YES;
    bannerView.currentPageDotImage = [UIImage imageNamed:@"bannerSelected"];
    bannerView.pageDotImage = [UIImage imageNamed:@"bannerDefault"];
    [shadowView addSubview:bannerView];
    bannerView.titlesGroup = @[@"123", @"345", @"456"];
    return view;
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
    
    static NSString *identifier = @"WKNewCell";
    WKNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKNewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.estimatedRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTV.estimatedRowHeight = 120;
    }
    return _mainTV;
}


@end
