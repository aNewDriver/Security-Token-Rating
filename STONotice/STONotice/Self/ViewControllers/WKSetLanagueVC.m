//
//  WKSetLanagueVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSetLanagueVC.h"
#import "WKLanguageTool.h"
#import "WKSetLanagueCell.h"

@interface WKSetLanagueVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;


@end

@implementation WKSetLanagueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    self.title = WKGetStringWithKeyFromTable(@"displayLanguage", nil);
    self.dataSource = @[@{@"key" : EN, @"value" : @"English"},
                        @{@"key" : CNS, @"value" : @"简体中文"}
                        ];
    
//    @{@"key" : FR, @"value" : @"Français"},
//    @{@"key" : KOR, @"value" : @"한국어"},
//    @{@"key" : XBY, @"value" : @"Español"},
//    @{@"key" : JP, @"value" : @"日本語"}
    self.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
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

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.height.equalTo(self.view);
    }];

}

- (void)saveWithIndexPath:(NSIndexPath *)indexPath {
    

    NSUInteger index = self.currentIndexPath.row;
    NSString *lanague;
    switch (index) {
        case 1:
            lanague = CNS;
            break;
        case 0:
            lanague = EN;
            break;
        case 2:
            lanague = FR;
            break;
        case 3:
            lanague = KOR;
            break;
        case 4:
            lanague = XBY;
            break;
        case 5:
            lanague = JP;
            break;
        default:
            break;
    }
    [[WKLanguageTool sharedInstance] setNewLanguage:lanague];
}

#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"WKSetLanagueCell";
    WKSetLanagueCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKSetLanagueCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.indexPath = indexPath;
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    [cell updateCellWithDic:dic];
    
    NSString *defaultL = [[WKLanguageTool sharedInstance] currentLanague];
    NSString *normalL = [dic valueForKey:@"key"];

    if ([normalL isEqualToString: defaultL]) {
        self.currentIndexPath = indexPath;
    } else if ([defaultL containsString:@"zh-Hans"] && [normalL isEqualToString:CNS]) {
        self.currentIndexPath = indexPath;
    } else if (defaultL == nil && indexPath.row == 0) {
        self.currentIndexPath = indexPath;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath != _currentIndexPath) {
        WKSetLanagueCell *haveSelecetdCell = [tableView cellForRowAtIndexPath:self.currentIndexPath];
        [haveSelecetdCell didDeselected];
        
        WKSetLanagueCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell didSelected];
        self.currentIndexPath = indexPath;
        [self saveWithIndexPath:indexPath];
    }
}
                          
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    WKSetLanagueCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell didDeselected];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}


#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTV.backgroundColor = BACKGROUND_COLOR;
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTV.estimatedRowHeight = 120.0f;
    }
    return _mainTV;
}

@end



