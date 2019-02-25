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
#import "WKNewsDetailVC.h"
#import "WKNewsManager.h"


@interface WKNewsViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) NSMutableArray *bannerArray;

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UIView *shdowView;

@end

@implementation WKNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self baseConfigure];
    [self setupDownRefresh];
    [self setupUpRefresh];
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.height.equalTo(self.view);
    }];
    
}

- (UIView *)createBannerView {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    [view addSubview:self.shdowView];
    [self.shdowView addSubview:self.bannerView];
    return view;
}

#pragma mark - MJ

- (void)setupUpRefresh
{
    self.mainTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestNewListWithType:WKRefreshType_loadMore];
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
        [self requestNewListWithType:WKRefreshType_refresh];
    }];
    [self.mainTV.mj_header beginRefreshing];
}

- (void)requestNewListWithType:(WKRefreshType)type {
    
    if (type == WKRefreshType_refresh) {
        self.currentPage = 1;
        [self.mainTV.mj_footer resetNoMoreData];
        
    } else {
        self.currentPage += 1;
    }
    
    
    
    [WKNewsManager requestNewsWithCurrentPage:_currentPage success:^(id  _Nonnull response) {
        
        NSArray *array = [NSArray modelArrayWithClass:[WKPostInfoModel class] json:response];
        
        [self.bannerArray removeAllObjects];
        
        if (type == WKRefreshType_refresh) {
            [self.newsListArray removeAllObjects];
            [self.mainTV.mj_header endRefreshing];
            for (WKPostInfoModel *model in array) {
                if (model.categories.count > 1) { //!< 说明是banner
                    [self.bannerArray addObject:model];
                } else {
                    [self.newsListArray addObject:model];
                }
            }
        } else {
            NSMutableArray *newListA = @[].mutableCopy;
            for (WKPostInfoModel *model in array) {
                if (model.categories.count > 1) { //!< 说明是banner
                } else {
                    [newListA addObject:model];
                }
            }
            if (newListA.count > 0) { //!< 说明还有
                [self.newsListArray addObjectsFromArray:array];
                [self.mainTV.mj_footer endRefreshing];
            } else {
                self.currentPage -= 1;
                [self.mainTV.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        if (self.newsListArray.count > 0) {
            if (self.newsListArray.count < 10) {
                self.mainTV.mj_footer.hidden = YES;
            } else {
                self.mainTV.mj_footer.hidden = NO;
            }
            [self.mainTV reloadData];
        } else {
            self.mainTV.mj_footer.hidden = YES;
            
        }
        self.mainTV.tableHeaderView = [self createBannerView];
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (NSMutableArray *)getBannerImageUrlArray {
    NSMutableArray *array = @[].mutableCopy;
    
    [self.bannerArray enumerateObjectsUsingBlock:^(WKPostInfoModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *metaStr = model.content.rendered;
        NSArray *subStrArray = [metaStr componentsSeparatedByString:@"\n"];
        NSArray *resultArray = [self stringArraySub:subStrArray startChar:@">" endChar:@"</"];
        model.resultContentArray = resultArray;

        
        NSString *imageStr = [resultArray[1] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
        NSString *imaUrl = [imageStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
        NSString *resS = [imaUrl substringWithRange:NSMakeRange(1, imaUrl.length - 3)];
        
        [array addObject:resS];
    }];
    
    return array;
}

- (NSMutableArray *)getBannerTitleArray {
    
    NSMutableArray *array = @[].mutableCopy;
    [self.bannerArray enumerateObjectsUsingBlock:^(WKPostInfoModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:model.title.rendered];
    }];
    return array;
}

- (NSArray *)stringArraySub:(NSArray *)array startChar:(NSString *)startChar endChar:(NSString *)endChar{
    NSMutableArray *resultArray = @[].mutableCopy;
    for (NSString *string in array) {
        if (![string isEmpty]) {
            NSString *str = [string subStrAtCharsRangeWithStartChar:startChar endChar:endChar];
            [resultArray addObject:str];
        }
    }
    return resultArray.copy;
}

#pragma mark - delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    WKPostInfoModel *model = self.bannerArray[index];
    
    WKNewsDetailVC *detailVC = [[WKNewsDetailVC alloc] initWithModel:model];
    detailVC.title = WKGetStringWithKeyFromTable(@"newsDetailtitle", nil);
    detailVC.formBanner = NO;

    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"WKNewCell";
    WKPostInfoModel *model = self.newsListArray[indexPath.row];
    WKNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKNewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell updateCellWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.estimatedRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKPostInfoModel *model = self.newsListArray[indexPath.row];

    WKNewsDetailVC *detailVC = [[WKNewsDetailVC alloc] initWithModel:model];
    
    detailVC.title = WKGetStringWithKeyFromTable(@"newsDetailtitle", nil);
    detailVC.formBanner = NO;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray new];
    }
    return _bannerArray;
}

- (NSMutableArray *)newsListArray {
    if (!_newsListArray) {
        _newsListArray = [NSMutableArray new];
    }
    return _newsListArray;
}

- (UIView *)shdowView {
    if (!_shdowView) {
        _shdowView = [[UIView alloc] initWithFrame:CGRectMake(15, 12, SCREEN_WIDTH - 30.0f, 176)];
        _shdowView.layer.cornerRadius = 5.0f;
        _shdowView.layer.shadowOpacity = 1.0f;
        _shdowView.layer.shadowOffset = CGSizeMake(0, 2);
        _shdowView.layer.shadowColor = RGBCOLOR(151, 151, 151).CGColor;
    }
    return _shdowView;
}

- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30.0f, 176) imageNamesGroup:[self getBannerImageUrlArray]];
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _bannerView.autoScrollTimeInterval = 3.0f;
        _bannerView.layer.cornerRadius = 5.0f;
        _bannerView.layer.masksToBounds = YES;
        _bannerView.currentPageDotImage = [UIImage imageNamed:@"bannerSelected"];
        _bannerView.pageDotImage = [UIImage imageNamed:@"bannerDefault"];
        _bannerView.titleLabelHeight = 80.0f;
        _bannerView.titleLabelTextFont = SPICAL_FONT(16.0f);
        _bannerView.titlesGroup = [self getBannerTitleArray];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

@end
