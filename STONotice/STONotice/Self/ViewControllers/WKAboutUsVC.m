//
//  WKAboutUsVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKAboutUsVC.h"
#import "WKBaseWebViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "WKAboutUsCell.h"


@interface WKAboutUsVC ()<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *versionL;
@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation WKAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = WKGetStringWithKeyFromTable(@"aboutUs", nil);
    self.titles = @[WKGetStringWithKeyFromTable(@"customerServer", nil)];
    self.dataSource = @[@"support@securitytokenratings.info"];
    [self configureUIAndFrame];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//展示
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//隐藏
}

- (void)configureUIAndFrame {
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.mainTV setTableHeaderView:[self configureHeader]];
}

- (UIView *)configureHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210.0f)];
    view.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:self.iconImage];
    [view addSubview:self.versionL];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(60);
        make.width.height.equalTo(@70.0f);
    }];
    
    [self.versionL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(self.iconImage.mas_bottom).offset(10);
        make.width.equalTo(self.versionL.mas_width);
        make.height.equalTo(self.versionL.mas_height);
    }];
    
    return view;
}

#pragma mark - method

-(void)launchMailApp
{
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: self.dataSource[0]];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:email]]) {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
    }
}

#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"WKAboutUsCell";
    WKAboutUsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKAboutUsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = self.titles[indexPath.row];
    NSString *detailStr = self.dataSource[indexPath.row];
    [cell configureUI:str detail:detailStr];
    
    cell.tapClickCallBack = ^{
        [self launchMailApp];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUND_COLOR;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}



#pragma mark - get

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.layer.cornerRadius = 10.0f;
        _iconImage.layer.masksToBounds = YES;
        _iconImage.image = [UIImage imageNamed:@"aboutUsIcon"];
    }
    return _iconImage;
}

- (UILabel *)versionL {
    if (!_versionL) {
        _versionL = [[UILabel alloc] init];
        _versionL.textAlignment = NSTextAlignmentCenter;
        _versionL.font = SPICAL_FONT(12.0f);
        _versionL.textColor = TitleTextColor;
        NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _versionL.text = [NSString stringWithFormat:@"Version %@", app_Version];
    }
    return _versionL;
}


#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTV.estimatedRowHeight = 120.0f;
    }
    return _mainTV;
}



@end
