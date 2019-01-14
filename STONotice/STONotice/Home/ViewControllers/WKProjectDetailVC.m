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

@interface WKProjectDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;


@end

@implementation WKProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    self.title = @"detail";
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.height.equalTo(self.view);
    }];
}

#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 5;
    }
    if (section == 1) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 3) { //!< 基本cell
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"价格: $123456789";
        
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
        return cell;
    } else if (indexPath.section == 4) { //!< 评论cell
        static NSString *identifier = @"WKDiscussCell";
        WKDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[WKDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return cell;
    }
    
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH, 20.0f)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.font = BOLD_NORMAL_FONT(18.0f);
    NSString *title = @"基本信息";
    if (section == 1) {
        title = @"项目介绍";
    } else if (section == 2) {
        title = @"团队成员";
    } else if (section == 3) {
        title = @"相关网站";
    } else if (section == 4) {
        title = @"最新评论";
    }
    label.text = title;
    
    [BGView addSubview:label];
    return BGView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
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


@end
