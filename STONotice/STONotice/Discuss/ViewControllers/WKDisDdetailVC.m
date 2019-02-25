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
#import "WKCustomDisNavBar.h"
#import "WKDisDetailHeaderView.h"
#import "WKHomeManager.h"
#import "WKProjectDetailVC.h"




@interface WKDisDdetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, strong) WKCommentView *commentView;
@property (nonatomic, strong) WKCustomDisNavBar *customNavBar;
@property (nonatomic, assign) BOOL needRightButton;
@property (nonatomic, strong) WKPostInfoModel *model;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) UILabel *noCommentL;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL isTopicDis; //!< 是否是topic

@end

@implementation WKDisDdetailVC

- (instancetype)initWithNeedRightButton:(BOOL)needRightButton model:(WKPostInfoModel *)model isTopicDis:(BOOL)isTopicDis{
    if (self = [super init]) {
        self.needRightButton = needRightButton;
        self.model = model;
        self.isTopicDis = isTopicDis;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self baseConfigure];
    [self setupDownRefresh];
    [self setupUpRefresh];
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

#pragma mark - MJ

- (void)setupUpRefresh
{
    self.mainTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestCommentsListWithType:WKRefreshType_loadMore];
    }];
    self.mainTV.mj_footer.hidden = YES;
}
- (void)setupDownRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mainTV.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self requestCommentsListWithType:WKRefreshType_refresh];
    }];
    [self.mainTV.mj_header beginRefreshing];
}

#pragma mark- request
- (void)requestCommentsListWithType:(WKRefreshType)type {
    
    if (type == WKRefreshType_refresh) {
        self.currentPage = 1;
        [self.mainTV.mj_footer resetNoMoreData];

    } else {
        self.currentPage += 1;
    }
    
    [WKHomeManager requestCommentsWithPostId:self.model.postId page:self.currentPage success:^(id  _Nonnull response) {
        
        if (type == WKRefreshType_refresh) {
            [self.mainTV.mj_header endRefreshing];
            self.comments = [NSArray modelArrayWithClass:[WKCommentModel class] json:response].mutableCopy;

        } else {
            NSArray *array = [NSArray modelArrayWithClass:[WKCommentModel class] json:response];
            if (array.count > 0) { //!< 说明还有
                [self.comments addObjectsFromArray:array];
                [self.mainTV.mj_footer endRefreshing];

            } else {
                self.currentPage -= 1;
                [self.mainTV.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        
        if (self.comments.count > 0) {
            self.noCommentL.hidden = YES;
            if (self.comments.count < 10) {
                self.mainTV.mj_footer.hidden = YES;
            } else {
                self.mainTV.mj_footer.hidden = NO;
            }
            [self.mainTV reloadData];
        } else {
            self.mainTV.mj_footer.hidden = YES;
            self.noCommentL.hidden = NO;
        }
        
    } fail:^(NSError * _Nonnull error) {
        [self.mainTV.mj_header endRefreshing];
        [self.mainTV.mj_footer  endRefreshing];
    }];
}

#pragma mark - configure

- (void)baseConfigure {
    
    self.currentPage = 1;
    self.comments = @[].mutableCopy;
    
    [self.view addSubview:self.mainTV];
//    [self.view addSubview:self.commentView];
    [self.mainTV addSubview:self.noCommentL];
    [self configureNavView];
//    CGFloat height  = ([self isLiuHaiScreen] ? 34.0f : 0.0f) + 60.0f;
    CGFloat y = [self isLiuHaiScreen] ? 112 : 88;
//    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.equalTo(@(height));
//    }];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(y);
        make.height.equalTo(self.view).offset(- y);
    }];
    [self.noCommentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mainTV);
        make.top.equalTo(self.mainTV.mas_centerY).offset(125 / 2);
        make.width.equalTo(self.noCommentL.mas_width);
        make.height.equalTo(self.noCommentL.mas_height);
    }];
    
    CGFloat headerHeight = self.isTopicDis ? 145 : 125;
    
    WKDisDetailHeaderView *headerView = [[WKDisDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    [headerView updateUIWithModel:self.model isTopicDis:self.isTopicDis];
    self.mainTV.tableHeaderView = headerView;
    
}

- (void)configureNavView {
    CGFloat height = [self isLiuHaiScreen] ? 112 : 88;
    
    self.customNavBar = [[WKCustomDisNavBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) navImageName:self.model.disscussModel.backIconUrl iconImageName:self.model.disscussModel.iconUrl needRightButton:self.needRightButton];
    [self.view addSubview:self.customNavBar];
    
//    weakify(self);
    self.customNavBar.goBack = ^{
//        strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    self.customNavBar.goToDetail = ^{
//        strongify(self);
        
        [self pushToProjectDetail];
        
    };
}
- (NSArray *)stringArraySub:(NSArray *)array startChar:(NSString *)startChar endChar:(NSString *)endChar{
    NSMutableArray *resultArray = @[].mutableCopy;
    for (NSString *string in array) {
        if (![string isEmpty]) {
            [resultArray addObject:[string subStrAtCharsRangeWithStartChar:startChar endChar:endChar]];
        }
    }
    return resultArray.copy;
}

- (void)pushToProjectDetail {
    
    WKProjectDetailVC *detailVC;
    
    NSArray *array = self.navigationController.viewControllers;
    for (UIViewController *vc in array) {
        if ([vc isMemberOfClass:[WKProjectDetailVC class]]) {
            detailVC = (WKProjectDetailVC *)vc;
        }
    }
    
    if (detailVC) {
        [self.navigationController popToViewController:detailVC animated:YES];
        return;
    }
    
    if (!detailVC) {
        detailVC = [[WKProjectDetailVC alloc] initWithDetailModel:self.model];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}



#pragma mark - delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    WKCommentModel *model = self.comments[indexPath.row];

    WKDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [cell updateCellWithModel:model];

    return cell;

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
            WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
            
            if (model == nil || model.token == nil) { //!< 未登录
                WKLoginVC *loginVC = [[WKLoginVC alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
            } else if (model != nil && model.token != nil){
                WKCommentVC *commentVC = [[WKCommentVC alloc] init];
                commentVC.postId = self.model.postId;
                commentVC.refreshBlock = ^{
                    [self setupDownRefresh];
                };
                [self.navigationController pushViewController:commentVC animated:YES];
            }
        };
    }
    return _commentView;
}

- (UILabel *)noCommentL {
    if (!_noCommentL) {
        _noCommentL = [[UILabel alloc] init];
        _noCommentL.text = WKGetStringWithKeyFromTable(@"noComment", nil);
        _noCommentL.font = SPICAL_FONT(14.0f);
        _noCommentL.textColor = DetailTextColor;
    }
    return _noCommentL;
}

@end
