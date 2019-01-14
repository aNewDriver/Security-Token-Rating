//
//  WKSetLanagueVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSetLanagueVC.h"
#import "WKLanguageTool.h"

@interface WKSetLanagueVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;


@end

@implementation WKSetLanagueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    self.dataSource = @[@"简体中文", @"繁體中文", @"English", @"French", @"Korean", @"Spanish", @"Japanese"];
    self.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.height.equalTo(self.view);
    }];
    
    [self configureRightItemsWithItemNameArray:@[@"save"] actionNameArray:@[@"save"]];
}

- (void)save {
    
    NSUInteger index = self.currentIndexPath.row;
    NSString *lanague;
    switch (index) {
        case 0:
            lanague = CNS;
            break;
        case 1:
            lanague = CNF;
            break;
        case 2:
            lanague = EN;
            break;
        case 3:
            lanague = FR;
            break;
        case 4:
            lanague = KOR;
            break;
        case 5:
            lanague = XBY;
            break;
        case 6:
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
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSString *str = self.dataSource[indexPath.row];
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(16.0f), NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.currentIndexPath = indexPath;
    
    NSLog(@"currentIndexPath = %@", self.currentIndexPath);
}
                          
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}


#pragma mark - get

- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTV.estimatedRowHeight = 120.0f;
    }
    return _mainTV;
}

@end



