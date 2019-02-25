//
//  WKCommentVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKCommentVC.h"
#import "UITextView+WKPlaceHolder.h"
#import "WKDiscussManager.h"

@interface WKCommentVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *mainTextView;


@end

@implementation WKCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = WKGetStringWithKeyFromTable(@"commentVCTitle", nil);
    [self configureRightItemsWithItemNameArray:@[WKGetStringWithKeyFromTable(@"send", nil)] itemColorArray:@[LoginRegisterBlue] itemFontArray:@[SPICAL_DETAIL_FONT(15.0f)] actionNameArray:@[@"submit"]];
    [self configureUIAndFrame];
}

- (void)submit {
    [self.view endEditing:YES];
    if (self.mainTextView.text.length > 0) {
        
        NSString *str = (self.mainTextView.text.length > 400) ? [self.mainTextView.text substringToIndex:400] : self.mainTextView.text;
        
        [WKDiscussManager commentProjectWithPostId:self.postId content:str success:^(id  _Nonnull response) {
            
            NSDictionary *dic = (NSDictionary *)response;
            NSString *postId = dic[@"id"];
            
            if (postId != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view makeToast:WKGetStringWithKeyFromTable(@"postSuccess", nil) duration:1.5f position:@(CGPointMake(SCREEN_WIDTH / 2, 200))];
                    [self performSelector:@selector(pop) withObject:nil afterDelay:1.5f];
                });
            }
            
        } fail:^(NSError * _Nonnull error) {
            
            
        }];
    } else {
        
        [self.view makeToast:WKGetStringWithKeyFromTable(@"pleaseInput", nil) duration:1.5f position:@(CGPointMake(SCREEN_WIDTH / 2, 200))];
    }
}

- (void)pop {
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.refreshBlock) {
        self.refreshBlock();
    }
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
        textView.text = resultStr;
        return NO;
    }
    
    return YES;
}

#pragma mark - get

- (UITextView *)mainTextView {
    if (!_mainTextView) {
        _mainTextView = [[UITextView alloc] init];
        _mainTextView.backgroundColor = [UIColor clearColor];
        _mainTextView.delegate = self;
        _mainTextView.placeholder = WKGetStringWithKeyFromTable(@"commentPlaceHolder", nil);
        _mainTextView.font = SPICAL_FONT(14.0f);
    }
    return _mainTextView;
}

@end
