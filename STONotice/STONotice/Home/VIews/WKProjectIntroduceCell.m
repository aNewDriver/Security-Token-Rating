//
//  WKProjectIntroduceCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKProjectIntroduceCell.h"

@interface WKProjectIntroduceCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *linkBtn;
@property (nonatomic, assign) ProjectIntroduceCellType projectIntroduceCellType;

@end

@implementation WKProjectIntroduceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ProjectIntroduceCellType:(ProjectIntroduceCellType)projectIntroduceCellType {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.projectIntroduceCellType = projectIntroduceCellType;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.detailLabel];

    if (self.projectIntroduceCellType == ProjectIntroduceCellType_haveName) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.linkBtn];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15.0f);
            make.height.equalTo(@20.0f);
            make.width.equalTo(self.nameLabel.mas_width);
        }];
        [self.linkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.left.equalTo(self.nameLabel.mas_right).offset(10.0f);
            make.height.width.equalTo(@20.0f);
        }];
        
    }
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        if (self.projectIntroduceCellType == ProjectIntroduceCellType_haveName) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10.0f);
        } else {
            make.top.equalTo(self.contentView).offset(15.0f);
        }
        make.height.equalTo(self.detailLabel.mas_height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15.0f);
    }];
    
    

}

- (void)btnClick{
    
}


#pragma mark - get

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = SYSTEM_NORMAL_FONT(14.0f);
        _nameLabel.text = @"ke.wang";
    }
    return _nameLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = SYSTEM_NORMAL_FONT(14.0f);
        _detailLabel.text = @"jahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsfjahsdkjhasdhajshdajsgjhadsf";
    }
    return _detailLabel;
}

- (UIButton *)linkBtn {
    if (!_linkBtn) {
        _linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _linkBtn.backgroundColor = [UIColor grayColor];
        _linkBtn.layer.cornerRadius = 10;
        [_linkBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkBtn;
}


@end
