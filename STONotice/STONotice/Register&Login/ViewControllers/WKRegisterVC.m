//
//  WKRegisterVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#define RegisterTextTagBegian  2000


#import "WKRegisterVC.h"
#import "WKLoginVC.h"

@interface WKRegisterVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *loginL;
@property (nonatomic, strong) UITextField *userNameT;
@property (nonatomic, strong) UITextField *emailT;
@property (nonatomic, strong) UITextField *pswT;
@property (nonatomic, strong) UITextField *cpswT;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *loginBtn;


@end

@implementation WKRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [self configureFrame];
    [self configureGoBackIcon];
    self.title = NSLocalizedString(@"registerTitle", nil) ? NSLocalizedString(@"registerTitle", nil) : @"Register";
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
}

- (void)goBackbtnClick {
    
    NSArray *array = self.navigationController.viewControllers;
    if (array.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)configureGoBackIcon {
    UIButton *goBack = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat y = [self isLiuHaiScreen] ? 44 : 24;
    goBack.frame = CGRectMake(15.0f, y + 7, 10, 18.0f);
    [goBack setImage:[UIImage imageNamed:@"whiteGoBackIcon"] forState:UIControlStateNormal];
    [goBack addTarget:self action:@selector(goBackbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBack];
}

#pragma mark - public method

- (void)createNameLabelWithText:(NSString *)text textField:(UITextField *)textField{
    UILabel *label = [[UILabel alloc] init];
    label.font = SYSTEM_NORMAL_FONT(14.0f);
    label.textColor = RGBCOLOR(102, 102, 102);
    label.text = text;
    
    [self.backView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(15.0f);
        make.centerY.equalTo(textField);
        make.height.equalTo(@20.f);
        make.width.equalTo(label.mas_width);
    }];
}

- (void)createLineWithTextField:(UITextField *)textField {
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BACKGROUND_COLOR;
    line.tag = textField.tag * 2;
    [self.backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(15.0f);
        make.top.equalTo(textField.mas_bottom).offset(10.0f);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@1.0f);
    }];
}

- (void)loginBtnClick {
    
    NSArray *array = self.navigationController.viewControllers;
    if (array.count > 1 && [array[0] isKindOfClass:[WKLoginVC class]]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    WKLoginVC *login = [[WKLoginVC alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
}

#pragma mark - configureUI

- (void)configureUI {
    self.view.backgroundColor = LoginRegisterBlue;
    [self.view addSubview:self.backView];
    [self.view addSubview:self.titleLabel];
    [self.backView addSubview:self.loginL];
    [self.backView addSubview:self.userNameT];
    [self.backView addSubview:self.emailT];
    [self.backView addSubview:self.pswT];
    [self.backView addSubview:self.cpswT];
    [self.backView addSubview:self.registerBtn];
    [self.backView addSubview:self.loginBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction {
    [self.view endEditing:YES];
}

- (void)configureFrame {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.backView.mas_top).offset(-44.0f);
        make.height.equalTo(@40.0f);
        make.width.equalTo(@(SCREEN_WIDTH - 30.0f));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15.0f);
        make.right.equalTo(self.view).offset(-15.0f);
        make.top.equalTo(self.view).offset(200.0f);
        make.height.equalTo(@400.0f);
    }];
    
    [self.loginL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(30.0f);
        make.width.equalTo(@80.0f);
        make.height.equalTo(@30.0f);
    }];
    
    [self.emailT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(80.0f);
        make.top.equalTo(self.loginL.mas_bottom).offset(30.0f);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@(20.0f));
    }];
    
    [self createNameLabelWithText:@"Email" textField:self.emailT];
    [self createLineWithTextField:self.userNameT];
    
    [self.userNameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailT.mas_left).offset(10.0f);
        make.top.equalTo(self.emailT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.userNameT.mas_right);
        make.height.equalTo(@(20.0f));
    }];
    [self createNameLabelWithText:@"NickName" textField:self.userNameT];
    [self createLineWithTextField:self.emailT];

    
    [self.pswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameT.mas_left);
        make.top.equalTo(self.userNameT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.userNameT.mas_right);
        make.height.equalTo(@(20.0f));
    }];
    
    [self createNameLabelWithText:@"Password" textField:self.pswT];
    [self createLineWithTextField:self.pswT];
    
    [self.cpswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pswT.mas_left).offset(60.0f);
        make.top.equalTo(self.pswT.mas_bottom).offset(20.0f);
        make.right.equalTo(self.pswT.mas_right);
        make.height.equalTo(@(20.0f));
    }];
    
    [self createNameLabelWithText:@"Confirm Password" textField:self.cpswT];
    [self createLineWithTextField:self.cpswT];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.cpswT.mas_bottom).offset(40.0f);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@(46.0f));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.registerBtn.mas_bottom).offset(24.0f);
        make.height.equalTo(@(30.0f));
        make.width.equalTo(self.loginBtn.mas_width);
    }];
}

#pragma mark - delegete
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSUInteger tag = textField.tag * 2;
    
    UIView *line = [self.backView viewWithTag:tag];
    
    line.backgroundColor = BACKGROUND_COLOR;
    //    textField.layer.borderColor = nil;
    //    textField.layer.borderWidth = 0;
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSUInteger tag = textField.tag * 2;
    UIView *line = [self.backView viewWithTag:tag];
    line.backgroundColor = LoginRegisterBlue;
    //    textField.layer.borderColor = LoginRegisterBlue.CGColor;
    //    textField.layer.borderWidth = 1;
    return YES;
}




#pragma - mark - method

- (void)btnClick {
    
    //!< 已有账号 登陆
    [self.view endEditing:YES];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = SYSTEM_NORMAL_FONT(26.0f);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Security Token Ratings";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)loginL {
    if (!_loginL) {
        _loginL = [[UILabel alloc] init];
        _loginL.font = SYSTEM_NORMAL_FONT(22.0f);
        _loginL.textColor = LoginRegisterBlue;
        _loginL.textAlignment = NSTextAlignmentCenter;
        _loginL.text = @"Regisier";
    }
    return _loginL;
}


- (UITextField *)userNameT {
    if (!_userNameT) {
        _userNameT = [[UITextField alloc] init];
        _userNameT.delegate = self;
        _userNameT.backgroundColor = [UIColor clearColor];
        NSString *str = NSLocalizedString(@"userName", nil) ? NSLocalizedString(@"userName", nil) : @"UserName";
        _emailT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(14.0f)}];
        _emailT.font = SYSTEM_NORMAL_FONT(14.0f);
        _userNameT.tag = RegisterTextTagBegian + 1;
    }
    return _userNameT;
}
- (UITextField *)emailT {
    if (!_emailT) {
        _emailT = [[UITextField alloc] init];
        _emailT.delegate = self;
        _emailT.backgroundColor = [UIColor clearColor];
        NSString *str = NSLocalizedString(@"email", nil) ? NSLocalizedString(@"email", nil) : @"Email";
        _emailT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(14.0f)}];
        _emailT.font = SYSTEM_NORMAL_FONT(14.0f);
        _emailT.tag = RegisterTextTagBegian + 2;

    }
    return _emailT;
}

- (UITextField *)pswT {
    if (!_pswT) {
        _pswT = [[UITextField alloc] init];
        _pswT.delegate = self;
        _pswT.backgroundColor = [UIColor clearColor];
        NSString *str = NSLocalizedString(@"password", nil) ? NSLocalizedString(@"password", nil) : @"Password";
        _pswT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(14.0f)}];
        _pswT.font = SYSTEM_NORMAL_FONT(14.0f);
        _pswT.tag = RegisterTextTagBegian + 3;

    }
    return _pswT;
}

- (UITextField *)cpswT {
    if (!_cpswT) {
        _cpswT = [[UITextField alloc] init];
        _cpswT.delegate = self;
        _cpswT.backgroundColor = [UIColor clearColor];
        NSString *str = NSLocalizedString(@"confirmPassword", nil) ? NSLocalizedString(@"confirmPassword", nil) : @"ConfirmPassword";
        _cpswT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(14.0f)}];
        _cpswT.font = SYSTEM_NORMAL_FONT(14.0f);
        _cpswT.tag = RegisterTextTagBegian + 4;

    }
    return _cpswT;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setBackgroundColor:LoginRegisterBlue];
        _registerBtn.layer.cornerRadius = 4.0f;
        [_registerBtn setTitle:NSLocalizedString(@"registerTitle", nil) ? NSLocalizedString(@"registerTitle", nil) : @"Register" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 4.0f;
        [_backView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:RGBACOLOR(0, 0, 0, 0.17) opacity:0.12];
    }
    return _backView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *str = @"Already have an account? Login";
        NSArray *array = [str componentsSeparatedByString:@"?"];
        NSString *firstStr = array[0];
        NSString *secStr = array[1];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(153, 153, 153)} range:NSMakeRange(0, firstStr.length + 1)];
        [attStr addAttributes:@{NSForegroundColorAttributeName : LoginRegisterBlue} range:NSMakeRange(firstStr.length + 1, secStr.length)];
        [attStr addAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(13.0f)} range:NSMakeRange(0, str.length)];
        //        [_forgrtBtn setTitle: forState:UIControlStateNormal];
        [_loginBtn setAttributedTitle:attStr forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
