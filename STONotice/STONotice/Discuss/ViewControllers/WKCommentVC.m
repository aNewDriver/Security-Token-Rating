//
//  WKCommentVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKCommentVC.h"
#import "UITextView+WKPlaceHolder.h"

@interface WKCommentVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *mainTextView;


@end

@implementation WKCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureRightItemsWithItemNameArray:@[@"发布"] actionNameArray:@[@"submit"]];
    [self configureUIAndFrame];
}

- (void)submit {
    
}

- (void)configureUIAndFrame {
    [self.view addSubview:self.mainTextView];
    [self.mainTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(10.0f);
        make.right.equalTo(self.view).offset(-10.0f);
        make.height.equalTo(@(300.0f));
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *resultStr = textView.text;
    if ([text isEqualToString:@""]) {
        if (range.location == 0) {
            resultStr = @"";
        } else {
            resultStr = [resultStr substringToIndex:range.location];
        }
    } else {
        resultStr = [resultStr stringByAppendingString:text];
    }
    
    if (resultStr.length > 400) {
        resultStr = [resultStr substringToIndex:400];
    }
    
    NSLog(@"%@", resultStr);
    
    return YES;
}

#pragma mark - get

- (UITextView *)mainTextView {
    if (!_mainTextView) {
        _mainTextView = [[UITextView alloc] init];
        _mainTextView.backgroundColor = BACKGROUND_COLOR;
        _mainTextView.layer.cornerRadius = 4.0f;
        _mainTextView.layer.borderWidth = 1.0f;
        _mainTextView.layer.borderColor = [UIColor blackColor].CGColor;
        _mainTextView.delegate = self;
        _mainTextView.placeholder = @"写下你的想法(请控制在400字以内)";
    }
    return _mainTextView;
}

@end
