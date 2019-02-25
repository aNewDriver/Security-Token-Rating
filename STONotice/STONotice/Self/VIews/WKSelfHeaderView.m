//
//  WKSelfHeaderView.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/15.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKSelfHeaderView.h"


@interface WKSelfHeaderView ()

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *emailL;
@property (nonatomic, strong) UIImageView *goIcon;
@property (nonatomic, strong) UILabel *unLoginL;
@property (nonatomic, assign) BOOL canTap;


@end

@implementation WKSelfHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self baseC];
        [self configureUI];
        self.canTap = NO;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)tapClick {
    if (self.canTap) {
        if (self.tapClicked) {
            self.tapClicked();
        }
    }
}

//!< 更新信息
- (void)updateSelfInfo {
    
    WKLoginRegiserInfoModel *model = [[WKLoginInfoManager sharedInsetance] getLoginInfo];
    BOOL isEmpty = model.token == nil;
    if (model != nil && !isEmpty){ //!< 已登录
        self.unLoginL.hidden = YES;
        self.nameL.hidden = NO;
        self.emailL.hidden = NO;
        self.canTap = NO;

        self.nameL.text = model.user_nicename;
        self.emailL.text = model.user_email;
    } else {
        self.unLoginL.hidden = NO;
        self.nameL.hidden = YES;
        self.emailL.hidden = YES;
        self.canTap = YES;
        self.unLoginL.text = WKGetStringWithKeyFromTable(@"tapToLogin", nil);
    }
}


- (void)baseC {
    [self dropShadowWithOffset:CGSizeMake(0, 2) radius:4 color:RGBCOLOR(0, 0, 0) opacity:0.5];
    [self.layer addSublayer:[self drawAGradientLayerWithColors:@[RGBCOLOR(89, 149, 248),RGBCOLOR(75, 139, 250), RGBCOLOR(61, 130, 252)] frame:self.frame]];
}

- (void)configureUI {
//    [self addSubview:self.header];
    [self addSubview:self.nameL];
//    [self addSubview:self.emailL];
//    [self addSubview:self.goIcon];
//    [self addSubview:self.unLoginL];
    
    
//    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(15.0f);
//        make.centerY.equalTo(self).offset(15.0f);
//        make.height.equalTo(@(40.0f));
//        make.width.mas_equalTo(40);
//    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.centerY.equalTo(self).offset(15.0f);
        make.height.equalTo(@30.0f);
        make.width.equalTo(self.nameL.mas_width);
    }];
//
//    [self.emailL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.header.mas_right).offset(15.0f);
//        make.bottom.equalTo(self.header.mas_bottom);
//        make.height.equalTo(@20.0f);
//        make.width.equalTo(self.emailL.mas_width);
//    }];
//
//    [self.unLoginL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.header.mas_right).offset(15.0f);
//        make.centerY.equalTo(self.header);
//        make.height.equalTo(@20.0f);
//        make.width.equalTo(self.unLoginL.mas_width);
//    }];
//
//    [self.goIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-15.0f);
//        make.centerY.equalTo(self.header.mas_centerY);
//        make.height.equalTo(@16.0f);
//        make.width.equalTo(@(8));
//    }];
//
    
    
}


#pragma mark - get

- (UIImageView *)header {
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.layer.cornerRadius = 20.0f;
        _header.layer.masksToBounds = YES;
        _header.backgroundColor = [UIColor clearColor];
        _header.image = [UIImage imageNamed:@"myselfHeader"];
    }
    return _header;
}
- (UIImageView *)goIcon {
    if (!_goIcon) {
        _goIcon = [[UIImageView alloc] init];
        _goIcon.layer.masksToBounds = YES;
        _goIcon.backgroundColor = [UIColor clearColor];
        _goIcon.image = [UIImage imageNamed:@"whiteGoInIcon"];
        _goIcon.hidden = YES;
    }
    return _goIcon;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.backgroundColor = [UIColor clearColor];
        _nameL.font = SPICAL_FONT(20.0f);
        _nameL.textColor = [UIColor whiteColor];
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.text = WKGetStringWithKeyFromTable(@"setting", nil);
    }
    return _nameL;
}

- (UILabel *)emailL {
    if (!_emailL) {
        _emailL = [[UILabel alloc] init];
        _emailL.backgroundColor = [UIColor clearColor];
        _emailL.font = SPICAL_DETAIL_FONT(14.0f);
        _emailL.textColor = [UIColor whiteColor];
        _emailL.textAlignment = NSTextAlignmentLeft;
        _emailL.text = @"Flora.bi@bankorus.com";
    }
    return _emailL;
}
- (UILabel *)unLoginL {
    if (!_unLoginL) {
        _unLoginL = [[UILabel alloc] init];
        _unLoginL.backgroundColor = [UIColor clearColor];
        _unLoginL.font = SPICAL_FONT(16.0f);
        _unLoginL.textColor = [UIColor whiteColor];
        _unLoginL.textAlignment = NSTextAlignmentLeft;
        _unLoginL.hidden = YES;
    }
    return _unLoginL;
}

@end
