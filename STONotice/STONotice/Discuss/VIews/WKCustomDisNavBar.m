//
//  WKCustomDisNavBar.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKCustomDisNavBar.h"

@interface WKCustomDisNavBar ()

@property (nonatomic, strong) UIImageView *customNavBar;
@property (nonatomic, strong) NSString *navImageName;
@property (nonatomic, strong) NSString *iconImageName;
@property (nonatomic, assign) BOOL needRightButton;


@end

@implementation WKCustomDisNavBar


- (instancetype)initWithFrame:(CGRect)frame
                 navImageName:(NSString *)navImageName
                iconImageName:(NSString *)iconImageName
              needRightButton:(BOOL)needRightButton {
    if (self = [super initWithFrame:frame]) {
        self.navImageName = navImageName;
        self.iconImageName = iconImageName;
        self.needRightButton = needRightButton;
        
        [self configureNavView];
        
    }
    return self;
}

#pragma mark - navMethod

- (void)goBackbtnClick {
    if (self.goBack) {
        self.goBack();
    }
}

- (void)rightBtnCilck {
    if (self.goToDetail) {
        self.goToDetail();
    }
}


#pragma mark - baseConfigure

- (void)configureNavView {
    
    self.customNavBar = [[UIImageView alloc] initWithFrame:self.frame];
    [self.customNavBar sd_setImageWithURL:[NSURL URLWithString:self.navImageName]];
    self.customNavBar.userInteractionEnabled = YES;
    
    [self configureGoBackIcon]; //!< goBack
    [self configureIcon]; //!< icon
    
    if (self.needRightButton) {
        [self configureRightBtn];
    }
    [self addSubview:self.customNavBar];
}

- (UIButton *)configureGoBackIcon {
    UIButton *goBack = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat y = [self isLiuHaiScreen] ? 44 : 24;
    [self.customNavBar addSubview:goBack];
    //    goBack.frame = CGRectMake(15.0f, y + 7, 10, 18.0f);
    [goBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.customNavBar).offset(15.0f);
        make.top.equalTo(self.customNavBar).offset(y + 7);
        make.width.equalTo(@10.0f);
        make.height.equalTo(@18.0f);
    }];
    [goBack setEnlargeEdge:20];
    
    [goBack setImage:[UIImage imageNamed:@"whiteGoBackIcon"] forState:UIControlStateNormal];
    [goBack addTarget:self action:@selector(goBackbtnClick) forControlEvents:UIControlEventTouchUpInside];
    return goBack;
}

- (UIButton *)configureRightBtn {
    
    UIButton *goBack = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat y = [self isLiuHaiScreen] ? 44 : 24;
    [self.customNavBar addSubview:goBack];
    
    //    goBack.frame = CGRectMake(SCREEN_WIDTH - 100 - 15.0f, y + 7, 100, 18.0f);
    //
    [goBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.customNavBar).offset(-15.0f);
        make.top.equalTo(self.customNavBar).offset(y + 7);
        make.height.equalTo(@18.0f);
        make.width.equalTo(goBack.mas_width);
    }];
    
    [goBack setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:WKGetStringWithKeyFromTable(@"projectDetail", nil) attributes:@{NSFontAttributeName : SPICAL_FONT(15.0f), NSForegroundColorAttributeName : [UIColor whiteColor]}] forState:UIControlStateNormal];
    [goBack addTarget:self action:@selector(rightBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    return goBack;
}

- (UIImageView *)configureIcon {
    if ([self.iconImageName isEmpty]) {
        return nil;
    }
    CGFloat y = [self isLiuHaiScreen] ? 68 : 48;
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.layer.cornerRadius = 45 / 2;
    imageV.layer.masksToBounds = YES;
    [self.customNavBar addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.customNavBar.mas_centerX);
        make.top.equalTo(self.customNavBar).offset(y + 19);
        make.width.height.equalTo(@45.0f);
    }];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.iconImageName]];
    
    return imageV;
}



@end
