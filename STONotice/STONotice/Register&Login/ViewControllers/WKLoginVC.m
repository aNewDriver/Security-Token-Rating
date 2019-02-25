//
//  WKLoginVC.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#define TextTagBegian  1000


#import "WKLoginVC.h"
#import "WKRegisterVC.h"
#import "WKRegisterManager.h"


@interface WKLoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *loginL;
@property (nonatomic, strong) UILabel *emailL;
@property (nonatomic, strong) UITextField *emailT;
@property (nonatomic, strong) UILabel *pswL;
@property (nonatomic, strong) UITextField *pswT;
@property (nonatomic, strong) UIButton *continueBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation WKLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = WKGetStringWithKeyFromTable(@"loginTitle", nil);
    [self configureUI];
    [self configureFrame];
    [self configureGoBackIcon];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
}

- (UILabel *)getMistakeLabelWithTextField:(UITextField *)textField {
    UILabel *label = [self.backView viewWithTag:textField.tag * 3];
    return label;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSUInteger tag = textField.tag * 2;
    UIView *line = [self.backView viewWithTag:tag];
    line.backgroundColor = BACKGROUND_COLOR;
    
    UILabel *label = [self getMistakeLabelWithTextField:textField];
    if ([textField.text isEmpty]) {
        NSString *str;
        if (textField == self.emailT) {
            str = WKGetStringWithKeyFromTable(@"emailEmpty", nil);
        } else {
            str = WKGetStringWithKeyFromTable(@"passwordEmpty", nil);

        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    NSUInteger tag = textField.tag * 2;
    UIView *line = [self.backView viewWithTag:tag];
    line.backgroundColor = LoginRegisterBlue;

    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *resultStr = textField.text;
    if ([string isEqualToString:@""]) {
        if (range.location == 0) {
            resultStr = @"";
        } else {
            resultStr = [resultStr substringToIndex:range.location];
        }
    } else {
        resultStr = [resultStr stringByAppendingString:string];
    }
    
    UILabel *label = [self getMistakeLabelWithTextField:textField];
    label.text = @"";
    
    
//    if (textField == self.emailT) { //!< 邮箱校验
//        if (![resultStr emailAddressJude]) {
//            label.text = WKGetStringWithKeyFromTable(@"emailFormatWrong", nil);
//        } else {
//            label.text = @"";
//        }
//    }
    
    return YES;
}

- (void)goBackbtnClick {
    
    NSArray *array = self.navigationController.viewControllers;
    if (array.count > 1 && [array[0] isKindOfClass:[WKRegisterVC class]]) {
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


#pragma mark - configureUI

- (void)configureUI {
    self.view.backgroundColor = LoginRegisterBlue;
    [self.view addSubview:self.backView];
    [self.view addSubview:self.titleLabel];
    [self.backView addSubview:self.loginL];
    [self.backView addSubview:self.emailL];
    [self.backView addSubview:self.pswL];
    [self.backView addSubview:self.emailT];
    [self.backView addSubview:self.pswT];
    [self.backView addSubview:self.continueBtn];
    [self.backView addSubview:self.registerBtn];
    
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
        make.height.equalTo(@327.0f);
        make.top.equalTo(self.view).offset(200.0f);
    }];
    
    [self.loginL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(30.0f);
        make.width.equalTo(@80.0f);
        make.height.equalTo(@30.0f);
    }];
    
    [self.emailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(15.0f);
        make.height.equalTo(@20.0f);
        make.top.equalTo(self.loginL.mas_bottom).offset(30.0f);
        make.width.equalTo(self.emailL.mas_width);
    }];
    
    [self.emailT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(90.0f);
        make.centerY.equalTo(self.emailL);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@20.0f);
    }];
    [self createLineWithTextField:self.emailT];
    
    [self.pswL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailL);
        make.height.equalTo(@20.0f);
        make.top.equalTo(self.emailT.mas_bottom).offset(31.0f);
        make.width.equalTo(self.emailL.mas_width);
    }];
    
    [self.pswT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(90.0f);
        make.centerY.equalTo(self.pswL);
        make.right.equalTo(self.backView.mas_right).offset(-15.0f);
        make.height.equalTo(@20.0f);
    }];
    [self createLineWithTextField:self.pswT];

  
    [self.continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.pswT.mas_bottom).offset(50.0f);
        make.right.equalTo(self.pswT.mas_right);
        make.height.equalTo(@(46.0f));
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.continueBtn.mas_centerX);
        make.top.equalTo(self.continueBtn.mas_bottom).offset(20.0f);
        make.height.equalTo(@(30.0f));
        make.width.equalTo(self.registerBtn.mas_width);
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
    
    
    UILabel *mistakeL = [[UILabel alloc] init];
    mistakeL.textColor = RGBCOLOR(238, 26, 26);
    mistakeL.textAlignment = NSTextAlignmentLeft;
    mistakeL.font = SPICAL_FONT(10.0f);
    mistakeL.tag = textField.tag * 3;
    mistakeL.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:mistakeL];
    
    [mistakeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(line.mas_bottom).offset(1.0f);
        make.height.equalTo(@10.0f);
    }];
}


#pragma mark - method

- (void)btnClick {
    //!< 登陆完成 跳转回去
    
    
    BOOL canLogin = YES;
    UILabel *mistakeL;
    if (self.emailT.text == nil || [self.emailT.text isEmpty]) {
        mistakeL = [self getMistakeLabelWithTextField:self.emailT];
        mistakeL.text = WKGetStringWithKeyFromTable(@"nickNameEmpty", nil);
        canLogin = NO;
    }
    if (self.pswT.text == nil || [self.pswT.text isEmpty]){
        mistakeL = [self getMistakeLabelWithTextField:self.pswT];
        mistakeL.text = WKGetStringWithKeyFromTable(@"passwordEmpty", nil);
        canLogin = NO;
    }
    if (!canLogin) {
        return;
    }
    
    for (UITextField *subV in self.backView.subviews) {
        if ([subV isKindOfClass:[UITextField class]]) {
            UILabel *misL = [self getMistakeLabelWithTextField:subV];
            if (![misL.text isEmpty]) {
                canLogin = NO;
            }
        }
    }
    if (!canLogin) {
        return;
    }
    
    
    NSDictionary *params = @{@"username":self.emailT.text, @"password":self.pswT.text};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WKRegisterManager LoginWithParams:params success:^(id  _Nonnull response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        [self performSelectorOnMainThread:@selector(dissView:) withObject:dic waitUntilDone:YES];
        
        NSLog(@"%@", response);
        
    } fail:^(id  _Nonnull error) {
        
        [self performSelectorOnMainThread:@selector(loginFail) withObject:nil waitUntilDone:YES];
        
    }];
}

- (void)loginFail {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    [self.view makeToast:WKGetStringWithKeyFromTable(@"loginFail", nil) duration:1.5f position:@(ToastCenter)];
    
}

- (void)dissView:(NSDictionary *)dic {
    
    [self.view endEditing:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    if ([dic.allKeys containsObject:@"token"]) {
        [[WKLoginInfoManager sharedInsetance] persistenceLoginInfoWithResponse:dic];
        
        [self.view endEditing:YES];
        self.navigationController.navigationBar.hidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    } else if ([dic.allKeys containsObject:@"message"]) {
        
        [self.view makeToast:WKGetStringWithKeyFromTable(@"loginFailPassword", nil) duration:1.5f position:@(ToastCenter)];
    } else {
        [self.view makeToast:WKGetStringWithKeyFromTable(@"loginFail", nil) duration:1.5f position:@(ToastCenter)];
    }

}

- (void)registerBtnClick {
    //!< 注册
    WKRegisterVC *registerVC = [[WKRegisterVC alloc] init];
    
    [self.navigationController pushViewController:registerVC animated:YES];
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
        _loginL.text = WKGetStringWithKeyFromTable(@"loginTitle", nil);
    }
    return _loginL;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 4.0f;
        [_backView dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:RGBACOLOR(0, 0, 0, 0.17) opacity:0.5];
    }
    return _backView;
}

- (UILabel *)emailL {
    if (!_emailL) {
        _emailL = [[UILabel alloc] init];
        _emailL.font = SPICAL_FONT(14.0f);
        _emailL.textColor = DetailTextColor;
        _emailL.text = WKGetStringWithKeyFromTable(@"userName", nil);;
    }
    return _emailL;
}

- (UILabel *)pswL {
    if (!_pswL) {
        _pswL = [[UILabel alloc] init];
        _pswL.font = SPICAL_FONT(14.0f);
        _pswL.textColor = DetailTextColor;
        _pswL.text = WKGetStringWithKeyFromTable(@"password", nil);;
    }
    return _pswL;
}

- (UITextField *)emailT {
    if (!_emailT) {
        _emailT = [[UITextField alloc] init];
        _emailT.delegate = self;
        _emailT.backgroundColor = [UIColor clearColor];
        NSString *str = WKGetStringWithKeyFromTable(@"enterNickName", nil);
        _emailT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SPICAL_DETAIL_FONT(14.0f)}];
        _emailT.font = SPICAL_DETAIL_FONT(14.0f);
        _emailT.tag = TextTagBegian + 1;

        
    }
    return _emailT;
}

- (UITextField *)pswT {
    if (!_pswT) {
        _pswT = [[UITextField alloc] init];
        _pswT.delegate = self;
        _pswT.secureTextEntry = YES;
        _pswT.backgroundColor = [UIColor clearColor];
         NSString *str = WKGetStringWithKeyFromTable(@"passwordPlaceHoder", nil);
        _pswT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : SPICAL_DETAIL_FONT(14.0f)}];
        _pswT.font = SPICAL_DETAIL_FONT(14.0f);
        _pswT.tag = TextTagBegian + 2;
    }
    return _pswT;
}

- (UIButton *)continueBtn {
    if (!_continueBtn) {
        _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_continueBtn setBackgroundColor:LoginRegisterBlue];
        _continueBtn.layer.cornerRadius = 4.0f;
        [_continueBtn setTitle:WKGetStringWithKeyFromTable(@"loginTitle", nil) forState:UIControlStateNormal];
        [_continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_continueBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueBtn;
}


- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *str = WKGetStringWithKeyFromTable(@"don't have account", nil);
        NSArray *array = [str componentsSeparatedByString:@"?"];
        NSString *firstStr = array[0];
        NSString *secStr = array[1];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(153, 153, 153)} range:NSMakeRange(0, firstStr.length + 1)];
        [attStr addAttributes:@{NSForegroundColorAttributeName : LoginRegisterBlue} range:NSMakeRange(firstStr.length + 1, secStr.length)];
        [attStr addAttributes:@{NSFontAttributeName : SPICAL_FONT(13.0f)} range:NSMakeRange(0, str.length)];
        
//        [_forgrtBtn setTitle: forState:UIControlStateNormal];
        [_registerBtn setAttributedTitle:attStr forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}




@end
