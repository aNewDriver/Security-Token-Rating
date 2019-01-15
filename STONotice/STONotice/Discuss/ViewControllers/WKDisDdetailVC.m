//
//  WKDisDdetailVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKDisDdetailVC.h"
#import "WKDiscussCell.h"
#import "WKCommentView.h"
#import "WKRegisterVC.h"
#import "WKCommentVC.h"
#import "WKLoginVC.h"


@interface WKDisDdetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, strong) WKCommentView *commentView;
@property (nonatomic, copy, nonnull) NSArray <UIColor *>*colors;

@property (nonatomic, assign) BOOL needRightButton;

@end

@implementation WKDisDdetailVC

- (instancetype)initWithColors:(nonnull NSArray <UIColor *>*)colors needRightButton:(BOOL)needRightButton {
    if (self = [super init]) {
        self.colors = colors;
        self.needRightButton = needRightButton;
    }
    return self;
}

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
    [self.view addSubview:self.mainTV];
    [self.view addSubview:self.commentView];
    [self configureNavView];
    CGFloat height  = ([self isLiuHaiScreen] ? 34.0f : 0.0f) + 40.0f;
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(self.view);
        make.height.equalTo(self.view).offset(-height);
    }];
    
    
}

- (void)configureNavView {
//    CGFloat y = [self isLiuHaiScreen] ? -44.0f : -24.0f;
    CGFloat height = [self isLiuHaiScreen] ? 88 : 64;
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    
    [self.view addSubview:view];
}

- (void)configureNAVButtons {
    //!< 返回
    UIButton *gobackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gobackButton.frame = CGRectMake(15, 30, 40, 40);
    gobackButton.backgroundColor = [UIColor whiteColor];
    [gobackButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    WKDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTV.estimatedRowHeight = 120.0f;
    }
    return _mainTV;
}

- (WKCommentView *)commentView {
    if (!_commentView) {
        _commentView = [[WKCommentView alloc] init];
        
        
        _commentView.tapClicked = ^{
            NSLog(@"tapClicked");
            
//            WKCommentVC *vc = [[WKCommentVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
            WKLoginVC *loginVC = [[WKLoginVC alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:^{

            }];
        };
    }
    return _commentView;
}

@end
