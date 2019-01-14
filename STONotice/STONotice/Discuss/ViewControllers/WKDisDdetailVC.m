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


@interface WKDisDdetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;
@property (nonatomic, strong) WKCommentView *commentView;

@end

@implementation WKDisDdetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfigure];
    // Do any additional setup after loading the view.
}

- (void)baseConfigure {
    [self.view addSubview:self.mainTV];
    [self.view addSubview:self.commentView];
    CGFloat height  = ([self isLiuHaiScreen] ? 34.0f : 0.0f) + 40.0f;
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
    [self.mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(self.view);
        make.height.equalTo(self.view).offset(-height);
    }];
    
}

#pragma mark - delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    WKDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WKDiscussCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
            NSLog(@"tapClicked");
            
            WKCommentVC *vc = [[WKCommentVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
//            WKRegisterVC *registerVC = [[WKRegisterVC alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerVC];
//            [self presentViewController:nav animated:YES completion:^{
//
//            }];
        };
    }
    return _commentView;
}

@end
