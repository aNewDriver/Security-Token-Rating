//
//  WKTopicDisCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKTopicDisCell.h"

@interface WKTopicDisCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UILabel *countL;

@end

@implementation WKTopicDisCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
    }
    return self;
}





#pragma mark - method

- (void)configureUIAndFrame {
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.imageV];
    [self.backView addSubview:self.titleL];
    [self.backView addSubview:self.detailL];
    [self.backView addSubview:self.countL];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5.0f);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0f);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(10.0f);
        make.top.equalTo(self.backView).offset(15.0f);
        make.height.equalTo(self.titleL.mas_height);
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
        make.top.equalTo(self.titleL.mas_bottom).offset(10.0f);
        make.width.height.equalTo(@80.0f);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageV.mas_left).offset(-10.0f);
        make.height.equalTo(self.detailL.mas_height);
        make.top.equalTo(self.titleL.mas_bottom).offset(10.0f);
        make.left.equalTo(self.backView).offset(10.0f);
    }];
    [self.countL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(10.0f);
        make.width.equalTo(@200.0f);
        make.height.equalTo(@15.0f);
        make.top.equalTo(self.detailL.mas_bottom).offset(15.0f);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-10.0f);
    }];
    
}


#pragma mark - get

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 4.0f;
        _backView.layer.shadowOpacity = 1;
        _backView.layer.shadowColor = RGBACOLOR(98, 98, 98, 0.12).CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _backView;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = BACKGROUND_COLOR;
    }
    return _imageV;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = RGBACOLOR(66, 66, 66, 1);
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = SYSTEM_NORMAL_FONT(16.0f);
        _titleL.text = @"In your opinion, what is the best faction to play in STO and why?";
        _titleL.numberOfLines = 2;
    }
    return _titleL;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = RGBACOLOR(66, 66, 66, 1);
        _detailL.textAlignment = NSTextAlignmentLeft;
        _detailL.font = SYSTEM_NORMAL_FONT(12.0f);
        _detailL.numberOfLines = 0;
        _detailL.text = @"不少从业者认为STO肩负着“繁荣区块链”的重任，然而也有人不相信那些非区块链行业的资产标的加上…";
    }
    return _detailL;
}

- (UILabel *)countL {
    if (!_countL) {
        _countL = [[UILabel alloc] init];
        _countL.textColor = RGBACOLOR(170, 170, 170, 1);
        _countL.textAlignment = NSTextAlignmentLeft;
        _countL.font = SYSTEM_NORMAL_FONT(10.0f);
        _countL.text = @"190阅读      30讨论";
    }
    return _countL;
}

@end
