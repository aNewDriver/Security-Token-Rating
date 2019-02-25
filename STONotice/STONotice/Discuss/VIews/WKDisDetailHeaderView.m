//
//  WKDisDetailHeaderView.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKDisDetailHeaderView.h"

@interface WKDisDetailHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) BOOL isTopicDis;

@end

@implementation WKDisDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAndFrame];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)updateUIWithModel:(WKPostInfoModel *)model isTopicDis:(BOOL)isTopicDis{
    self.titleLabel.text = model.disscussModel.titleStr;
    
    if (isTopicDis) {
        self.detailLabel.numberOfLines = 4;
    } else {
        self.detailLabel.numberOfLines = 2;
    }
    
    self.detailLabel.attributedText = [model.disscussModel.detailStr attStrEncodeWithFont:SPICAL_DETAIL_FONT(14.0f) textColor:RGBCOLOR(102, 102, 102) textAlignment:NSTextAlignmentCenter];
    
//    self.detailLabel.text = model.disscussModel.detailStr;
}

- (void)configureUIAndFrame {
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.top.equalTo(self).offset(30.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.height.equalTo(self.titleLabel.mas_height);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.height.equalTo(self.detailLabel.mas_height);
    }];
}

#pragma mark - get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TitleTextColor;
        _titleLabel.font = SPICAL_FONT(16.0f);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"In your opinion, what is the best faction to play in STO and why?";
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = DetailTextColor;
        _detailLabel.font = SPICAL_FONT(12.0f);
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 2;
        _detailLabel.text = @"In your opinion, what is the best faction to play in STO and why?";
    }
    return _detailLabel;
}


@end
