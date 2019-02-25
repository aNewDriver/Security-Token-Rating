//
//  WKSetLanagueCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKSetLanagueCell.h"

@interface WKSetLanagueCell ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *selectedIcon;

@end

@implementation WKSetLanagueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithDic:(nonnull NSDictionary *)dic  {
    
    NSString *str = [dic valueForKey:@"value"];
    NSString *defaultL = [[WKLanguageTool sharedInstance] currentLanague];
    NSString *normalL = [dic valueForKey:@"key"];
    
    
    if ([normalL isEqualToString: defaultL] ) {
        self.selectedIcon.image = [UIImage imageNamed:@"duiHao"];
        self.titleL.textColor = LoginRegisterBlue;
    } else if ([defaultL containsString:@"zh-Hans"] && [normalL isEqualToString:CNS]) {
        self.selectedIcon.image = [UIImage imageNamed:@"duiHao"];
        self.titleL.textColor = LoginRegisterBlue;
        
    } else if (defaultL == nil && self.indexPath.row == 0) {
        self.selectedIcon.image = [UIImage imageNamed:@"duiHao"];
        self.titleL.textColor = LoginRegisterBlue;
    } else {
        self.selectedIcon.image = nil;
        self.titleL.textColor = RGBCOLOR(153, 153, 153);
    }
    self.titleL.text = str;
    
}

- (void)didSelected {
    self.selectedIcon.image = [UIImage imageNamed:@"duiHao"];
    self.titleL.textColor = LoginRegisterBlue;
}

- (void)didDeselected {
    self.titleL.textColor = RGBCOLOR(153, 153, 153);
    self.selectedIcon.image = nil;
}



- (void)configureUIAndFrame {
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.selectedIcon];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.width.equalTo(self.titleL.mas_width);
        make.height.equalTo(self.titleL.mas_height);
        
    }];

    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(- 0.5f);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(0.5f));
    }];
    
    [self.selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(- 15.0f);
        make.width.equalTo(@(16.0f));
        make.height.equalTo(@(10.0f));
    }];
}


#pragma mark - get

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = SPICAL_DETAIL_FONT(14.0f);
        _titleL.textColor = RGBCOLOR(153, 153, 153);
        _titleL.textAlignment = NSTextAlignmentLeft;
    }
    return _titleL;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR(216, 216, 216);
    }
    return _line;
}

- (UIImageView *)selectedIcon {
    if (!_selectedIcon) {
        _selectedIcon = [[UIImageView alloc] init];
        _selectedIcon.backgroundColor = [UIColor clearColor];
        _selectedIcon.layer.masksToBounds = YES;
    }
    return _selectedIcon;
}


@end
