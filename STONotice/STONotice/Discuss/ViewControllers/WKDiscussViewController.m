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

@interface WKDiscussViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;

@end

@implementation WKDiscussViewController

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
}

#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *ide = @"WKProjectDiscussCell";
        WKProjectDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
        
        if (!cell) {
            cell = [[WKProjectDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ide];
        }
        return cell;
    } else {
    
        static NSString *identifier = @"cell";
        WKTopicDisCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[WKTopicDisCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
            return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKDisDdetailVC *detailVC = [[WKDisDdetailVC alloc] init];
    detailVC.title = @"SpiceVC";
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0f)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 15, 30.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBCOLOR(98, 98, 108);
    label.font = SYSTEM_NORMAL_FONT(14.0f);
    NSString *str = @"Project Discussion Area";
    if (section == 1) {
        str = @"Topic Discussion Area";
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

@end
