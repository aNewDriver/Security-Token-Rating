//
//  WKSelfCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSelfCell.h"

@interface WKSelfCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *line;

@end

@implementation WKSelfCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BACKGROUND_COLOR;
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)configureUI:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)configureUIAndFrame {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(40.0f);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.titleLabel.mas_height);
        make.width.equalTo(@(100));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@(0.5f));
        make.width.equalTo(self.contentView);
    }];
    
}

#pragma mark - get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"hhhh";
    }
    return _titleLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}

@end
