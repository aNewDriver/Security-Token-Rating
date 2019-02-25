//
//  WKSelfCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSelfCell.h"

@interface WKSelfCell ()
@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIImageView *goIcon;

@end

@implementation WKSelfCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)configureUI:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)updateImageIconWithImageName:(NSString *)imageName hiddenRightItem:(BOOL)hiddenRightItem {
    self.imageIcon.image = [UIImage imageNamed:imageName];
    if (hiddenRightItem) {
        [self.goIcon setHidden:YES];
    } else {
        [self.goIcon setHidden:NO];
    }
}

- (void)configureUIAndFrame {
    
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.goIcon];
    
    [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.centerY.equalTo(self.contentView);
        make.height.width.equalTo(@20.0f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageIcon.mas_right).offset(15.0f);
        make.centerY.equalTo(self.imageIcon);
        make.height.equalTo(self.titleLabel.mas_height);
        make.width.equalTo(self.titleLabel.mas_width);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.top.equalTo(self.contentView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@(0.5f));
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.goIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(12.0f));
        make.width.equalTo(@(6));
    }];
}

#pragma mark - get

- (UIImageView *)imageIcon {
    if (!_imageIcon) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.layer.cornerRadius = 10.0f;
        _imageIcon.layer.masksToBounds = YES;
        _imageIcon.backgroundColor = [UIColor clearColor];
    }
    return _imageIcon;
}
- (UIImageView *)goIcon {
    if (!_goIcon) {
        _goIcon = [[UIImageView alloc] init];
        _goIcon.layer.masksToBounds = YES;
        _goIcon.backgroundColor = [UIColor clearColor];
        _goIcon.image = [UIImage imageNamed:@"goInIcon"];
    }
    return _goIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = SPICAL_DETAIL_FONT(15.0f);
        _titleLabel.textColor = DetailTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"hhhh";
    }
    return _titleLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBCOLOR(241, 241, 241);
    }
    return _line;
}

@end
