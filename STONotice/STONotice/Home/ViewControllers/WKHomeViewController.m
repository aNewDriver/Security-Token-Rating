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
#import "WKHomeManager.h"
#import "WKPostInfoModel.h"


@interface WKHomeViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *issuedArray; //!< 已发布
@property (nonatomic, strong) NSMutableArray *unIssueArray; //!< 未发布


@end

@implementation WKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self baseConfigure];
    [self setupDownRefresh];
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
//    self.mainTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//    }];
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mainTV.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    [self.mainTV.mj_header beginRefreshing];
}



#pragma mark - request

- (void)requestData {
    
    [self.mainTV.mj_header endRefreshing];
    
    [WKHomeManager requestProjectsWithCurrentPage:self.currentPage success:^(id  _Nonnull response) {
        
        NSArray *array = [NSArray modelArrayWithClass:[WKPostInfoModel class] json:response].mutableCopy;
        WKAllProjectModelManager *manager = [WKAllProjectModelManager sharedManager];
        manager.allProjectModels = array;
        [self.issuedArray removeAllObjects];
        [self.unIssueArray removeAllObjects];
        for (WKPostInfoModel *model in array) {
            if ([model.categories containsObject:@(WKPostCategary_issuedProject)]) {
                [self.issuedArray addObject:model];
            }
            
            if ([model.categories containsObject:@(WKPostCategary_unIssuedProject)]) {
                [self.unIssueArray addObject:model];
            }
        }
        
        [self.mainTV reloadData];
        
    } fail:^(NSError * _Nonnull error) {

        NSLog(@"%@", error.description);
        
    }];
}

#pragma mark - baseConfigure

- (void)baseConfigure {
//    self.view.backgroundColor = [UIColor redColor];
    [self configureBackImage];
    [self.view addSubview:self.mainTV];
    self.mainTV.tableHeaderView = [self headerView];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
}

- (void)configureBackImage {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0f)];
    imageV.image = [UIImage imageNamed:@"backImage"];
    
    CGFloat Y = [self isLiuHaiScreen] ? 44 : 24;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 , 25 + Y, SCREEN_WIDTH, 60)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.font = SPICAL_FONT(21.0f);
    label.text = WKGetStringWithKeyFromTable(@"homeTitle", nil);
    [imageV addSubview:label];
    
    [self.view addSubview:imageV];
}



- (UIView *)headerView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 105.0f);
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    
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
        return self.issuedArray.count;
    }
    return self.unIssueArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKPostInfoModel *model;
    if (indexPath.section == 0) {
        model = self.issuedArray[indexPath.row];
    } else {
        model = self.unIssueArray[indexPath.row];
    }
    
    static NSString *identifier = @"cell";
    WKProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKProjectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell updateCellWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WKPostInfoModel *model;
    
    if (indexPath.section == 0) {
        model = self.issuedArray[indexPath.row];
    } else {
        model = self.unIssueArray[indexPath.row];
    }
    WKProjectDetailVC *detailVC = [[WKProjectDetailVC alloc] initWithDetailModel:model];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0f)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 15, 30.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBCOLOR(153, 153, 153);
    label.font = SPICAL_FONT(14.0f);
    NSString *str = @"";
    if (section == 1) {
        str = WKGetStringWithKeyFromTable(@"unList", nil);
    }
    label.text = str;
    [view addSubview:label];
    
    
    if (self.unIssueArray.count > 0) {
        return view;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001f;
    }
    if (self.unIssueArray.count > 0) {
        return 40.0f;
    }
    return 0.001f;
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

- (NSMutableArray *)issuedArray {
    if (!_issuedArray) {
        _issuedArray = @[].mutableCopy;
    }
    return _issuedArray;
}

- (NSMutableArray *)unIssueArray {
    if (!_unIssueArray) {
        _unIssueArray = @[].mutableCopy;
    }
    return _unIssueArray;
}

@end
