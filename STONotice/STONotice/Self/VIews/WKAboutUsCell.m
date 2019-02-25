//
//  WKAboutUsCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/29.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKAboutUsCell.h"

@interface WKAboutUsCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UIView *line;

@end

@implementation WKAboutUsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)configureUI:(NSString *)title detail:(NSString *)detail{
    self.titleLabel.text = title;
    self.detailL.text = detail;
}

- (void)tapClick {
    if (self.tapClickCallBack) {
        self.tapClickCallBack();
    }
}


- (void)configureUIAndFrame {
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailL];
    [self.contentView addSubview:self.line];
    
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.titleLabel.mas_height);
        make.width.equalTo(self.titleLabel.mas_width);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.detailL.mas_height);
        make.width.equalTo(self.detailL.mas_width);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@(0.5f));
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    
}

#pragma mark - get



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = SPICAL_DETAIL_FONT(14.0f);
        _titleLabel.textColor = DetailTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"hhhh";
    }
    return _titleLabel;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.backgroundColor = [UIColor clearColor];
        _detailL.font = SPICAL_DETAIL_FONT(14.0f);
        _detailL.textColor = LoginRegisterBlue;
        _detailL.textAlignment = NSTextAlignmentRight;
        _detailL.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_detailL addGestureRecognizer:tap];
    }
    return _detailL;
}


- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(241, 241, 241);
    }
    return _line;
}



@end
