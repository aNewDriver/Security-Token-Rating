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
#import "WKRegisterManager.h"

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

@property (nonatomic, assign) BOOL registerBtnHaveClick;
@property (nonatomic, copy) NSDictionary *loginParams;



@end

@implementation WKRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [self configureFrame];
    [self configureGoBackIcon];
    
    
    
    self.title = WKGetStringWithKeyFromTable(@"registerTitle", nil);
    
    self.registerBtnHaveClick = NO;
    
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
    [goBack setEnlargeEdge:20];
    [self.view addSubview:goBack];
}

#pragma mark - public method

- (void)createNameLabelWithText:(NSString *)text textField:(UITextField *)textField{
    UILabel *label = [[UILabel alloc] init];
    label.font = SPICAL_FONT(14.0f);
    label.textColor = DetailTextColor;
    label.text = text;
    
    [self.backView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(15.0f);
        make.centerY.equalTo(textField);
        make.height.equalTo(@20.f);
        make.width.equalTo(label.mas_width);
    }];
}

- (UILabel *)getMistakeLabelWithTextField:(UITextField *)textField {
    UILabel *label = [self.backView viewWithTag:textField.tag * 3];
    return label;
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
    
    UILabel *mistakeL = [[UILabel alloc] init];
    mistakeL.textColor = RGBCOLOR(238, 26, 26);
    mistakeL.textAlignment = NSTextAlignmentLeft;
    mistakeL.font = SPICAL_FONT(10.0f);
    mistakeL.tag = textField.tag * 3;
    mistakeL.backgroundColor = [UIColor clearColor];
    mistakeL.numberOfLines = 2;
    [self.backView addSubview:mistakeL];
    
    [mistakeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(line.mas_bottom).offset(1.0f);
        make.height.equalTo(mistakeL.mas_height);
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
        make.height.equalTo(@420.0f);
    }];
    
    [self.loginL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(30.0f);
        make.width.equalTo(self.loginL.mas_width);
        make.height.equalTo(@30.0f);
    }];
    
    [self.emailT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(90.0f);
        make.top.equalTo(self.loginL.mas_bottom).offset(30.0f);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@(20.0f));
    }];
    
    [self createNameLabelWithText:WKGetStringWithKeyFromTable(@"email", nil) textField:self.emailT];
    [self createLineWithTextField:self.userNameT];
    
    [self.userNameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailT.mas_left);
        make.top.equalTo(self.emailT.mas_bottom).offset(31.0f);
        make.right.equalTo(self.userNameT.mas_right);
        make.height.equalTo(@(20.0f));
    }];
    [self createNameLabelWithText:WKGetStringWithKeyFromTable(@"userName", nil) textField:self.userNameT];
    [self createLineWithTextField:self.emailT];

    
    [self.pswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameT.mas_left);
        make.top.equalTo(self.userNameT.mas_bottom).offset(31.0f);
        make.right.equalTo(self.userNameT.mas_right);
        make.height.equalTo(@(20.0f));
    }];
    
    [self createNameLabelWithText:WKGetStringWithKeyFromTable(@"password", nil) textField:self.pswT];
    [self createLineWithTextField:self.pswT];
    
    [self.cpswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pswT.mas_left);
        make.top.equalTo(self.pswT.mas_bottom).offset(31.0f);
        make.right.equalTo(self.pswT.mas_right);
        make.height.equalTo(@(20.0f));
    }];
    
    [self createNameLabelWithText:WKGetStringWithKeyFromTable(@"confirmPassword", nil) textField:self.cpswT];
    [self createLineWithTextField:self.cpswT];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.cpswT.mas_bottom).offset(40.0f);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@(46.0f));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.registerBtn.mas_bottom).offset(20.0f);
        make.height.equalTo(@(30.0f));
        make.width.equalTo(self.loginBtn.mas_width);
    }];
}

- (NSString *)strWithTextField:(UITextField *)textField {
    NSString *str = @"";
    
    if (textField == self.emailT) {
        str = WKGetStringWithKeyFromTable(@"emailEmpty", nil);
    } else if (textField == self.userNameT) {
        str = WKGetStringWithKeyFromTable(@"nickNameEmpty", nil);
    } else if (textField == self.pswT) {
        str = WKGetStringWithKeyFromTable(@"passwordEmpty", nil);
    } else if (textField == self.cpswT) {
        str = WKGetStringWithKeyFromTable(@"cPasswordEmpty", nil);
    }
    
    return str;
}

#pragma mark - delegete
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSUInteger tag = textField.tag * 2;
    UIView *line = [self.backView viewWithTag:tag];
    line.backgroundColor = BACKGROUND_COLOR;
    
    
    UILabel *label = [self getMistakeLabelWithTextField:textField];
    if ([textField.text isEmpty]) {
        label.text = [self strWithTextField:textField];
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSUInteger tag = textField.tag * 2;
    UIView *line = [self.backView viewWithTag:tag];
    line.backgroundColor = LoginRegisterBlue;
    //    textField.layer.borderColor = LoginRegisterBlue.CGColor;
    //    textField.layer.borderWidth = 1;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *resultStr = textField.text.mutableCopy;
    if ([string isEqualToString:@""]) {
        if (range.location == 0) {
            resultStr = @"".mutableCopy;
        } else {
            resultStr = [resultStr substringToIndex:range.location].mutableCopy;
        }
    } else {
         [resultStr insertString:string atIndex:range.location];
    }
    
    UILabel *label = [self getMistakeLabelWithTextField:textField];
    label.text = @"";
    
    if (textField == self.emailT) { //!< 邮箱校验
        if (resultStr.length > 30) {
            label.text = WKGetStringWithKeyFromTable(@"emailNumberWrong", nil);
            return NO;
        } else {
            label.text = @"";
        }
        
        if (![resultStr emailAddressJude]) {
            label.text = WKGetStringWithKeyFromTable(@"emailFormatWrong", nil);
        } else {
            label.text = @"";
        }
        
        
    }
    
    if (textField == self.userNameT) {
        if (resultStr.length > 10) {
            label.text = WKGetStringWithKeyFromTable(@"nickNumberWrong", nil);
            return NO;
        } else {
            label.text = @"";
        }
    }
    
    if (textField == self.pswT) {
        if (resultStr.length < 8 || resultStr.length > 20) {
            label.text = WKGetStringWithKeyFromTable(@"passwordNumberWrong", nil);
        } else {
            label.text = @"";
        }
        if (resultStr.length > 20) {
            return NO;
        }
    }
    
    if (textField == self.cpswT && ![self.pswT.text isEmpty]) {
        if (![resultStr isEqualToString:self.pswT.text]) {
            label.text = WKGetStringWithKeyFromTable(@"cPasswordNotMatch", nil);
        } else {
            label.text = @"";
        }
    }
    
    
    return YES;
}

- (void)registerWithParams:(NSDictionary *)params {
    
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WKRegisterManager registerNewUserWithParams:params success:^(id  _Nonnull response) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        NSDictionary *dict = (NSDictionary *)response;
        
        NSString *failMessage = dict[@"message"];
        if ([failMessage containsString:@"Username already exists"] || [failMessage containsString:@"Email already exists"]) {
            self.registerBtnHaveClick = NO;
            [self performSelectorOnMainThread:@selector(registeFail:) withObject:dict waitUntilDone:YES];
        } else {
             [self login];
        }
        
    } fail:^(id  _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        self.registerBtnHaveClick = NO;
        
        NSLog(@"%@", error);
        
    }];
}

- (void)registeFail:(NSDictionary *)dict {
    
    NSString *failMessage = dict[@"message"];
    UILabel *misL;
    if ([failMessage containsString:@"Username already exists"]) {
        misL = [self getMistakeLabelWithTextField:self.userNameT];
        misL.text = WKGetStringWithKeyFromTable(@"nickHaveExist", nil);
    } else if ([failMessage containsString:@"Email already exists"]) {
        misL = [self getMistakeLabelWithTextField:self.emailT];
        misL.text = WKGetStringWithKeyFromTable(@"emailHaveExist", nil);
    }
    
}

//!< 注册完成后  直接进行登录
- (void)login {
    
    [WKRegisterManager LoginWithParams:self.loginParams success:^(id  _Nonnull response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        [self performSelectorOnMainThread:@selector(popView:) withObject:dic waitUntilDone:YES];

    } fail:^(id  _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        [self.view makeToast:WKGetStringWithKeyFromTable(@"loginFail", nil) duration:1.0f position:@(ToastCenter)];
        
        self.registerBtnHaveClick = NO;
        
    }];
}

- (void)popView:(NSDictionary *)dic  {
    self.registerBtnHaveClick = NO;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    if ([dic.allKeys containsObject:@"token"]) {
        
        [[WKLoginInfoManager sharedInsetance] persistenceLoginInfoWithResponse:dic];
        self.navigationController.navigationBar.hidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    } else if ([dic.allKeys containsObject:@"message"]) {
        [self.view makeToast:@"register fail" duration:1.0f position:@(ToastCenter)];
    }
    
    
}


#pragma - mark - method

- (void)btnClick {
    
    [self.view endEditing:YES];
    BOOL canRegister = YES;
    
    UILabel *mistakeL;
    if (self.emailT.text == nil || [self.emailT.text isEmpty]) {
        mistakeL = [self getMistakeLabelWithTextField:self.emailT];
        mistakeL.text = WKGetStringWithKeyFromTable(@"emailEmpty", nil);
        canRegister = NO;
    }
    if (self.pswT.text == nil || [self.pswT.text isEmpty]){
        mistakeL = [self getMistakeLabelWithTextField:self.pswT];
        mistakeL.text = WKGetStringWithKeyFromTable(@"passwordEmpty", nil);
        canRegister = NO;
    }
    if (self.userNameT.text == nil || [self.userNameT.text isEmpty]){
        mistakeL = [self getMistakeLabelWithTextField:self.userNameT];
        mistakeL.text = WKGetStringWithKeyFromTable(@"nickNameEmpty", nil);
        canRegister = NO;
    }
    if (self.cpswT.text == nil || [self.cpswT.text isEmpty]){
        mistakeL = [self getMistakeLabelWithTextField:self.cpswT];
        mistakeL.text = WKGetStringWithKeyFromTable(@"cPasswordEmpty", nil);
        canRegister = NO;
    }
    if (!canRegister) {
        return;
    }
    
    for (UITextField *subV in self.backView.subviews) {
        if ([subV isKindOfClass:[UITextField class]]) {
            UILabel *misL = [self getMistakeLabelWithTextField:subV];
            if (![misL.text isEmpty]) {
                canRegister = NO;
            }
        }
    }
    if (canRegister) {
        
        NSString *userName = self.userNameT.text;
        NSString *email = self.emailT.text;
        NSString *passW = self.pswT.text;
        
        NSDictionary *parems = @{@"username":userName,
                                 @"email":email,
                                 @"password":passW};
        self.loginParams = @{@"username":userName,
                             @"password":passW
                             };
        if (!self.registerBtnHaveClick) {
            self.registerBtnHaveClick = YES;
            [self registerWithParams:parems];
        }
        
        
    } else {
        self.registerBtnHaveClick = NO;
    }
    
    
    
    //!< 注册方法
}


#pragma mark - get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = SPICAL_FONT(26.0f);
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
        _loginL.font = SPICAL_FONT(22.0f);
        _loginL.textColor = LoginRegisterBlue;
        _loginL.textAlignment = NSTextAlignmentCenter;
        _loginL.text = WKGetStringWithKeyFromTable(@"registerTitle", nil);
    }
    return _loginL;
}


- (UITextField *)userNameT {
    if (!_userNameT) {
        _userNameT = [[UITextField alloc] init];
        _userNameT.delegate = self;
        _userNameT.backgroundColor = [UIColor clearColor];
        NSString *str = WKGetStringWithKeyFromTable(@"nicknamePlaceHoder", nil);
        _userNameT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SPICAL_DETAIL_FONT(14.0f)}];
        _userNameT.font = SPICAL_DETAIL_FONT(14.0f);
        _userNameT.tag = RegisterTextTagBegian + 1;
    }
    return _userNameT;
}
- (UITextField *)emailT {
    if (!_emailT) {
        _emailT = [[UITextField alloc] init];
        _emailT.delegate = self;
        _emailT.backgroundColor = [UIColor clearColor];
        NSString *str = WKGetStringWithKeyFromTable(@"emailPlaceHoder", nil);
        _emailT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SPICAL_DETAIL_FONT(14.0f)}];
        _emailT.font = SPICAL_DETAIL_FONT(14.0f);
        _emailT.tag = RegisterTextTagBegian + 2;

    }
    return _emailT;
}

- (UITextField *)pswT {
    if (!_pswT) {
        _pswT = [[UITextField alloc] init];
        _pswT.delegate = self;
        _pswT.backgroundColor = [UIColor clearColor];
        _pswT.secureTextEntry = YES;
        NSString *str = WKGetStringWithKeyFromTable(@"registerPasswordPlaceHoder", nil);
        _pswT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SPICAL_DETAIL_FONT(14.0f)}];
        _pswT.font = SPICAL_DETAIL_FONT(14.0f);
        _pswT.tag = RegisterTextTagBegian + 3;

    }
    return _pswT;
}

- (UITextField *)cpswT {
    if (!_cpswT) {
        _cpswT = [[UITextField alloc] init];
        _cpswT.delegate = self;
        _cpswT.backgroundColor = [UIColor clearColor];
        _cpswT.secureTextEntry = YES;

        NSString *str =  WKGetStringWithKeyFromTable(@"verifyPlaceHoder", nil);
        _cpswT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SPICAL_DETAIL_FONT(14.0f)}];
        _cpswT.font = SPICAL_DETAIL_FONT(14.0f);
        _cpswT.tag = RegisterTextTagBegian + 4;

    }
    return _cpswT;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setBackgroundColor:LoginRegisterBlue];
        _registerBtn.layer.cornerRadius = 4.0f;
        [_registerBtn setTitle:WKGetStringWithKeyFromTable(@"registerTitle", nil) forState:UIControlStateNormal];
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
        NSString *str = WKGetStringWithKeyFromTable(@"already have account", nil);
        NSArray *array = [str componentsSeparatedByString:@"?"];
        NSString *firstStr = array[0];
        NSString *secStr = array[1];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(153, 153, 153)} range:NSMakeRange(0, firstStr.length + 1)];
        [attStr addAttributes:@{NSForegroundColorAttributeName : LoginRegisterBlue} range:NSMakeRange(firstStr.length + 1, secStr.length)];
        [attStr addAttributes:@{NSFontAttributeName : SPICAL_FONT(13.0f)} range:NSMakeRange(0, str.length)];
        //        [_forgrtBtn setTitle: forState:UIControlStateNormal];
        [_loginBtn setAttributedTitle:attStr forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
