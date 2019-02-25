//
//  WKProjectDetailVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKProjectDetailVC.h"
#import "WKProjectIntroduceCell.h"
#import "WKDiscussCell.h"
#import "WKProjectDetailHeaderView.h"
#import "WKProjectPriceCell.h"
#import "WKHomeManager.h"
#import "WKDisDdetailVC.h"

@interface WKProjectDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;

@property (nonatomic, strong) WKProjectDetailHeaderView *tabHeader;
@property (nonatomic, copy) NSArray *summaryTitleArray;
@property (nonatomic, strong) WKPostInfoModel *detailModel;
@property (nonatomic, copy) NSArray *comments;
@property (nonatomic, strong) UIButton *joinButton;


@end

@implementation WKProjectDetailVC

- (instancetype)initWithDetailModel:(WKPostInfoModel *)detailModel {
    if (self = [super init]) {
        self.detailModel = detailModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    self.title = WKGetStringWithKeyFromTable(@"projectDetailTitle", nil);
    
    self.summaryTitleArray = @[WKGetStringWithKeyFromTable(@"price", nil), WKGetStringWithKeyFromTable(@"priceUpdateTime", nil), WKGetStringWithKeyFromTable(@"regulationComply", nil), WKGetStringWithKeyFromTable(@"riskLevel", nil), WKGetStringWithKeyFromTable(@"officialWebsite", nil)];
    [self requestComments];
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.view addSubview:self.joinButton];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(self.view);
        make.height.equalTo(self.view).offset(- 52.0f);
    }];
    [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@52.0f);
    }];
    self.tabHeader = [[WKProjectDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0f)];
    [self.tabHeader updateUIWithModel:self.detailModel];
    self.tabHeader.segmentClick = ^(NSUInteger index) {
        if (index != 0) {
            if (index == 1) {
                if (self.detailModel.detailModel.teamMember.count > 0) {
                    [self.mainTV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index + 1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                } else {
                    [self.mainTV scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
                
            } else if (index == 2 ) {
                if (self.comments.count > 0) {
                    [self.mainTV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index + 1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                } else {
                    [self.mainTV scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
            }
        }
    };
    self.mainTV.tableHeaderView = self.tabHeader;
}

- (void)requestComments {
    [WKHomeManager requestCommentsWithPostId:self.detailModel.postId page:1  success:^(id  _Nonnull response) {
        
        self.comments = [NSArray modelArrayWithClass:[WKCommentModel class] json:response];
        
        [self.mainTV reloadData];
        
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)joinBtnClick {
    
    WKDisDdetailVC *disDetailVC;
    NSArray *array = self.navigationController.viewControllers;
    for (UIViewController *vc in array) {
        if ([vc isMemberOfClass:[WKDisDdetailVC class]]) {
            disDetailVC = (WKDisDdetailVC *)vc;
        }
    }
    
    if (disDetailVC) {
        [self.navigationController popToViewController:disDetailVC animated:YES];
        return;
    }
    
    if (!disDetailVC) {
        disDetailVC = [[WKDisDdetailVC alloc] initWithNeedRightButton:YES model:self.detailModel isTopicDis:NO];
        [self.navigationController pushViewController:disDetailVC animated:YES];
    }
}

#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 5;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return self.detailModel.detailModel.teamMember.count;
    }
    return (self.comments.count > 3) ? 3 : self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) { //!< 基本cell
        static NSString *identifier = @"cell";
        WKProjectPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[WKProjectPriceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        NSString *detailS = self.detailModel.detailModel.summarys[indexPath.row] ?  self.detailModel.detailModel.summarys[indexPath.row] : @"";
        [cell updateCellWithTitle:self.summaryTitleArray[indexPath.row] detail:detailS];
        
        return cell;
    } else if (indexPath.section == 1 || indexPath.section == 2) { //!< 介绍cell
        static NSString *identifier = @"WKProjectIntroduceCell";
        ProjectIntroduceCellType type = ProjectIntroduceCellType_noHaveName;
        if (indexPath.section == 2) {
            type = ProjectIntroduceCellType_haveName;
        }
        WKProjectIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[WKProjectIntroduceCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:identifier
                    ProjectIntroduceCellType:type];
        }
        [cell updateCellWithModel:self.detailModel index:indexPath.row];
        
        return cell;
    } else if (indexPath.section == 3) { //!< 评论cell
        static NSString *identifier = @"WKDiscussCell";
        WKCommentModel *model = self.comments[indexPath.row];
        WKDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[WKDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        [cell updateCellWithModel:model];
        return cell;
    }
    
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    UIView *blueV = [[UIView alloc] initWithFrame:CGRectMake(15, 12.5, 4, 15)];
    blueV.backgroundColor = LoginRegisterBlue;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27, 10, SCREEN_WIDTH, 20.0f)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = RGBCOLOR(66, 66, 6);
    label.font = BOLD_NORMAL_FONT(16);
    NSString *title = @"";
    if (section == 2) {
        title = WKGetStringWithKeyFromTable(@"teamMember", nil);
        [BGView addSubview:blueV];
    } else if (section == 3) {
        title = WKGetStringWithKeyFromTable(@"discussion", nil);
        [BGView addSubview:blueV];
    }
    label.text = title;
    
    [BGView addSubview:label];
    return BGView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.001f;
    }
    return 40.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];;
    if (section == 0) {
        footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        footer.backgroundColor = [UIColor whiteColor];
        UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 1)];
        line.backgroundColor = BACKGROUND_COLOR;
        [footer addSubview:line];
    } else {
        footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10.0f);
        footer.backgroundColor = BACKGROUND_COLOR;
    }
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 1.0f;
    }
    if (section == 3) {
        return 0.001;
    }
    return 10.00f;
}


#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTV.estimatedRowHeight = 200.0f;
    }
    return _mainTV;
}
- (NSArray *)comments {
    if (!_comments) {
        _comments = [NSArray new];
    }
    return _comments;
}

- (UIButton *)joinButton {
    if (!_joinButton) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = WKGetStringWithKeyFromTable(@"joinButton", nil);
        [_joinButton setTitle:title forState:UIControlStateNormal];
        [_joinButton setBackgroundColor:LoginRegisterBlue];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(joinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _joinButton;
}


@end
