//
//  WKRegisterVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKRegisterVC.h"
#import "WKLoginVC.h"

@interface WKRegisterVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userNameT;
@property (nonatomic, strong) UITextField *emailT;
@property (nonatomic, strong) UITextField *pswT;
@property (nonatomic, strong) UITextField *cpswT;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation WKRegisterVC

- (void)viewDidLoad {
    [self configureUI];
    [self configureFrame];
    self.title = NSLocalizedString(@"registerTitle", nil) ? NSLocalizedString(@"registerTitle", nil) : @"Register";
    self.view.backgroundColor = BACKGROUND_COLOR;
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - configureUI

- (void)configureUI {
    [self.view addSubview:self.userNameT];
    [self.view addSubview:self.emailT];
    [self.view addSubview:self.pswT];
    [self.view addSubview:self.cpswT]; 
    [self.view addSubview:self.registerBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction {
    [self.view endEditing:YES];
}

- (void)configureFrame {
    [self.userNameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset( 20.0f);
        make.top.equalTo(self.view).offset(20.0f );
        make.right.equalTo(self.view.mas_right).offset(-20.0f);
        make.height.equalTo(@(40.0f));
    }];
    
    [self.emailT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameT.mas_left);
        make.top.equalTo(self.userNameT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.userNameT.mas_right);
        make.height.equalTo(@(40.0f));
    }];
    
    [self.pswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailT.mas_left);
        make.top.equalTo(self.emailT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.emailT.mas_right);
        make.height.equalTo(@(40.0f));
    }];
    
    [self.cpswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pswT.mas_left);
        make.top.equalTo(self.pswT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.pswT.mas_right);
        make.height.equalTo(@(40.0f));
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cpswT.mas_left);
        make.top.equalTo(self.cpswT.mas_bottom).offset(40.0f);
        make.right.equalTo(self.cpswT.mas_right);
        make.height.equalTo(@(50.0f));
    }];
}


#pragma - mark - method

- (void)btnClick {
    
    //!< 已有账号 登陆
    
    WKLoginVC *loginVC = [[WKLoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
    
    NSString *userName = self.userNameT.text;
    NSString *email = self.emailT.text;
    NSString *passW = self.pswT.text;
    NSString *cPassW = self.cpswT.text;
    if ([userName isEmpty] || [email isEmpty] || [passW isEmpty] || [cPassW isEmpty]) {
        return;
    }
    
    if (![passW isEqualToString:cPassW]) {
        return;
    }
    
    //!< 注册方法
}


#pragma mark - get

- (UITextField *)userNameT {
    if (!_userNameT) {
        _userNameT = [[UITextField alloc] init];
        _userNameT.delegate = self;
        _userNameT.backgroundColor = [UIColor whiteColor];
        _userNameT.placeholder = NSLocalizedString(@"userName", nil) ? NSLocalizedString(@"userName", nil) : @"UserName";
    }
    return _userNameT;
}
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
        _pswT.placeholder = NSLocalizedString(@"password", nil) ? NSLocalizedString(@"password", nil) : @"Password";
    }
    return _pswT;
}

- (UITextField *)cpswT {
    if (!_cpswT) {
        _cpswT = [[UITextField alloc] init];
        _cpswT.delegate = self;
        _cpswT.backgroundColor = [UIColor whiteColor];
        _cpswT.placeholder = NSLocalizedString(@"confirmPassword", nil) ? NSLocalizedString(@"confirmPassword", nil) : @"ConfirmPassword";
    }
    return _cpswT;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setBackgroundColor:[UIColor whiteColor]];
        [_registerBtn setTitle:NSLocalizedString(@"registerTitle", nil) ? NSLocalizedString(@"registerTitle", nil) : @"Register" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

@end
