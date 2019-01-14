//
//  WKNewCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKNewCell.h"

@interface WKNewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *line;

@end

@implementation WKNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configureUIAndFrame];
    }
    return self;
}


- (void)configureUIAndFrame {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10.0f);
        make.right.equalTo(self.imageV.mas_left).offset(- 20.0f);
        make.height.equalTo(self.titleLabel.mas_height);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.0f);
        make.right.equalTo(self.imageV.mas_left).offset(- 20.0f);
        make.height.equalTo(self.detailLabel.mas_height);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0f);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10.0f);
        make.top.equalTo(self.contentView).offset(10.0f);
        make.width.equalTo(@(100));
        make.height.equalTo(@(80));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(20.0f);
        make.left.equalTo(self.contentView).offset(10.0f);
        make.right.equalTo(self.contentView).offset(-10.0f);
        make.height.equalTo(@1.0f);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];

}


#pragma mark - get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = SYSTEM_NORMAL_FONT(16.0f);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = RGBCOLOR(66, 66, 66);
        _titleLabel.text = @"标题标题标题标题标题标题标题标题标题标题标题标题标题";
        _titleLabel.numberOfLines = 3;
    }
    return _titleLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = SYSTEM_NORMAL_FONT(12.0f);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textColor = RGBCOLOR(170, 170, 170);
        _detailLabel.text = @"Bankorus 2小时前";
    }
    return _detailLabel;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageV;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBCOLOR(241, 241, 241);
    }
    return _line;
}


@end
