//
//  WKSelfViewController.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/8.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSelfViewController.h"
#import "WKSelfCell.h"
#import "WKSetLanagueVC.h"

@interface WKSelfViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, copy) NSArray *dataSource;


@end

@implementation WKSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTV];
    self.dataSource = @[@"我的信息", @"更换语言", @"关于我们"];
    // Do any additional setup after loading the view.
}


#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    WKSelfCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKSelfCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell configureUI:self.dataSource[indexPath.row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { //!< 关于我们
        
    } else if (indexPath.row == 1) {
        WKSetLanagueVC *setVC = [[WKSetLanagueVC alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTV;
}

@end
