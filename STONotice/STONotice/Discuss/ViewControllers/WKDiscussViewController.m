//
//  WKDiscussViewController.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKDiscussViewController.h"
#import "WKProjectDiscussCell.h"
#import "WKTopicDisCell.h"
#import "WKDisDdetailVC.h"
#import "WKDiscussManager.h"

@interface WKDiscussViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;

@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *iconImageArray;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *detailArray;
@property (nonatomic, assign) NSUInteger currentPage;


@property (nonatomic, copy) NSArray *projectDataSource;
@property (nonatomic, strong) NSMutableArray *topicDataSource;



@end

@implementation WKDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    [self setupDownRefresh];
    [self setupUpRefresh];
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    self.currentPage = 1;
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.height.equalTo(self.view);
    }];
}

#pragma mark - MJ

- (void)setupUpRefresh
{
    self.mainTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestTopicListWithType:WKRefreshType_loadMore];
    }];
    self.mainTV.mj_footer.hidden = YES;
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mainTV.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self requestProjectList];
    }];
    [self.mainTV.mj_header beginRefreshing];
}


- (void)requestProjectList {
    
    [self.mainTV.mj_header endRefreshing];
    WKAllProjectModelManager *manager = [WKAllProjectModelManager sharedManager];
    self.projectDataSource = manager.allProjectModels;
    [self requestTopicListWithType:WKRefreshType_refresh];
}


- (void)requestTopicListWithType:(WKRefreshType)type {
    
    if (type == WKRefreshType_refresh) {
        self.currentPage = 1;
        [self.mainTV.mj_footer resetNoMoreData];
        
    } else {
        self.currentPage += 1;
    }
    
    
    [WKDiscussManager requestTopicCommunityListWithCurrentPage:self.currentPage success:^(id  _Nonnull response) {
        
        if (type == WKRefreshType_refresh) {
            [self.mainTV.mj_header endRefreshing];
            self.topicDataSource = [NSArray modelArrayWithClass:[WKPostInfoModel class] json:response].mutableCopy;
        } else {
            NSArray *array = [NSArray modelArrayWithClass:[WKPostInfoModel class] json:response];
            if (array.count > 0) { //!< 说明还有
                [self.topicDataSource addObjectsFromArray:array];
                [self.mainTV.mj_footer endRefreshing];
                
            } else {
                self.currentPage -= 1;
                [self.mainTV.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        if (self.topicDataSource.count > 0) {
            if (self.topicDataSource.count < 10) {
                self.mainTV.mj_footer.hidden = YES;
            } else {
                self.mainTV.mj_footer.hidden = NO;
            }
            [self.mainTV reloadData];
        } else {
            self.mainTV.mj_footer.hidden = YES;
            
        }
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.topicDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *ide = @"WKProjectDiscussCell";
        WKProjectDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
        
        if (!cell) {
            cell = [[WKProjectDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ide];
        }
        
        cell.projectModelArray = self.projectDataSource;
        
        cell.didSelecetedAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
            
            WKPostInfoModel *model = self.projectDataSource[indexPath.row];
            WKDisDdetailVC *detailVC = [[WKDisDdetailVC alloc] initWithNeedRightButton:YES model:model isTopicDis:NO];
            
            [self.navigationController pushViewController:detailVC animated:YES];
        };

        return cell;
    } else {
    
        static NSString *identifier = @"cell";
        WKTopicDisCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[WKTopicDisCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        WKPostInfoModel *model = self.topicDataSource[indexPath.row];

        [cell updateCellWithModel:model];

        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKPostInfoModel *model = self.topicDataSource[indexPath.row];

    WKDisDdetailVC *detailVC = [[WKDisDdetailVC alloc] initWithNeedRightButton:NO model:model isTopicDis:YES];

    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180.f;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43.0f)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 15, 20.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBCOLOR(153, 153, 153);
    label.font = SPICAL_FONT(14.0f);
    NSString *str = WKGetStringWithKeyFromTable(@"projectDiscuss", nil);
    if (section == 1) {
        str = WKGetStringWithKeyFromTable(@"topicDiscuss", nil);;
    }
    label.text = str;
    
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}




#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTV.estimatedRowHeight = 180.0f;
        _mainTV.showsVerticalScrollIndicator = NO;
    }
    return _mainTV;
}

- (NSMutableArray *)projectDataSource {
    if (!_projectDataSource) {
        _projectDataSource = @[].mutableCopy;
    }
    return _projectDataSource;
}

- (NSMutableArray *)topicDataSource {
    if (!_topicDataSource) {
        _topicDataSource = @[].mutableCopy;
    }
    return _topicDataSource;
}

@end
