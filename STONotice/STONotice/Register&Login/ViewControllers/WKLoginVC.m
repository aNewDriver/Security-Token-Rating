//
//  WKLoginVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKLoginVC.h"

@interface WKLoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *emailT;
@property (nonatomic, strong) UITextField *pswT;
@property (nonatomic, strong) UIButton *continueBtn;
@property (nonatomic, strong) UIButton *forgrtBtn;
@property (nonatomic, strong) UILabel *desL;

@end

@implementation WKLoginVC

- (void)viewDidLoad {
    self.title = NSLocalizedString(@"loginTitle", nil) ? NSLocalizedString(@"loginTitle", nil) : @"Login";
    [self configureUI];
    [self configureFrame];
    [super viewDidLoad];
}

#pragma mark - configureUI

- (void)configureUI {
    [self.view addSubview:self.emailT];
    [self.view addSubview:self.pswT];
    [self.view addSubview:self.continueBtn];
    [self.view addSubview:self.forgrtBtn];
}

- (void)configureFrame {
    
    
    [self.emailT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20.0f);
        make.top.equalTo(self.view).offset(20.0f);
        make.right.equalTo(self.view.mas_right).offset(-20.0f);
        make.height.equalTo(@(40.0f));
    }];
    
    [self.pswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailT.mas_left);
        make.top.equalTo(self.emailT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.emailT.mas_right);
        make.height.equalTo(@(40.0f));
    }];
  
    [self.continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pswT.mas_left);
        make.top.equalTo(self.pswT.mas_bottom).offset(40.0f);
        make.right.equalTo(self.pswT.mas_right);
        make.height.equalTo(@(50.0f));
    }];
    
    [self.forgrtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.continueBtn.mas_centerX);
        make.top.equalTo(self.continueBtn.mas_bottom).offset(40.0f);
        make.height.equalTo(@(30.0f));
        make.width.equalTo(self.forgrtBtn.mas_width);
    }];
}


#pragma mark - method

- (void)btnClick {
    //!< 登陆完成 跳转回去
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];

    if ([self.emailT.text isEmpty] || [self.pswT.text isEmpty]) {
        return;
    }
    
    //!< 登陆
}

- (void)forgotBtnClick {
    //!< 忘记密码
    
    
}



#pragma mark - get


- (UITextField *)emailT {
    if (!_emailT) {
        _emailT = [[UITextField alloc] init];
        _emailT.delegate = self;
        _emailT.backgroundColor = [UIColor whiteColor];
        _emailT.placeholder = NSLocalizedString(@"email", nil) ? NSLocalizedString(@"email", nil) : @"Email";
    }
    return _emailT;
}

- (UITextField *)pswT {
    if (!_pswT) {
        _pswT = [[UITextField alloc] init];
        _pswT.delegate = self;
        _pswT.backgroundColor = [UIColor whiteColor];
        _pswT.placeholder = NSLocalizedString(@"password", nil) ? NSLocalizedString(@"password", nil) : @"password";
    }
    return _pswT;
}

- (UIButton *)continueBtn {
    if (!_continueBtn) {
        _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_continueBtn setBackgroundColor:[UIColor clearColor]];
        _continueBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _continueBtn.layer.cornerRadius = 3.0f;
        _continueBtn.layer.borderWidth = 0.5f;
        [_continueBtn setTitle:NSLocalizedString(@"loginBtn", nil) ? NSLocalizedString(@"loginBtn", nil) : @"Continue" forState:UIControlStateNormal];
        [_continueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_continueBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueBtn;
}


- (UIButton *)forgrtBtn {
    if (!_forgrtBtn) {
        _forgrtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *str = NSLocalizedString(@"forgotPSW", nil) ? NSLocalizedString(@"forgotPSW", nil) : @"Forgot your password?";
//        [_forgrtBtn setTitle: forState:UIControlStateNormal];
        [_forgrtBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_forgrtBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(13.0f), NSForegroundColorAttributeName : [UIColor blueColor]}] forState:UIControlStateNormal];
        [_forgrtBtn addTarget:self action:@selector(forgotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgrtBtn;
}



@end
