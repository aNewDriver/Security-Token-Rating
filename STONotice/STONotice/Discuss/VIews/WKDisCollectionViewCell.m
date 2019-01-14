//
//  WKDisCollectionViewCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKDisCollectionViewCell.h"

@interface WKDisCollectionViewCell ()

@property (nonatomic, strong) UIImageView *backImagV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *detailL;


@end

@implementation WKDisCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAndFrame];
    }
    return self;
}

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.backImagV];
    [self.backImagV addSubview:self.nameL];
    [self.backImagV addSubview:self.detailL];
    
    [self.backImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.width.equalTo(self.contentView);
    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(40.0f));
        make.centerX.equalTo(self.backImagV.mas_centerX);
        make.height.equalTo(self.nameL.mas_height);
        make.width.equalTo(self.backImagV);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImagV).offset(5.0f);
        make.right.equalTo(self.backImagV.mas_right).offset(-5.0f);
        make.top.equalTo(self.nameL.mas_bottom).offset(10.0f);
        make.height.equalTo(self.detailL.mas_height);
    }];
}

#pragma mark - get

- (UIImageView *)backImagV {
    if (!_backImagV) {
        _backImagV = [[UIImageView alloc] init];
        _backImagV.backgroundColor = [UIColor whiteColor];
        _backImagV.layer.cornerRadius = 5.0f;
//        _backImagV.layer.masksToBounds = YES;
        _backImagV.userInteractionEnabled = YES;
        _backImagV.layer.shadowOpacity = 1;
        _backImagV.layer.shadowColor = RGBACOLOR(98, 98, 98, 0.12).CGColor;
        _backImagV.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _backImagV;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.textColor = RGBACOLOR(66, 66, 66, 1);
        _nameL.textAlignment = NSTextAlignmentCenter;
        _nameL.font = SYSTEM_NORMAL_FONT(14.0f);
        _nameL.text = @"SpiceVC\nProject Discussion";
        _nameL.numberOfLines = 0;
    }
    return _nameL;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = RGBACOLOR(102, 102, 102, 1);
        _detailL.textAlignment = NSTextAlignmentCenter;
        _detailL.font = SYSTEM_NORMAL_FONT(12.0f);
        _detailL.text = @"SPiCE provides exposure to the massive growth of the Blockchain /Tokenization…";
        _detailL.numberOfLines = 4;
    }
    return _detailL;
}

@end
