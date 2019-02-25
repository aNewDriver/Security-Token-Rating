//
//  WKProjectPriceCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKProjectPriceCell.h"

@interface WKProjectPriceCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailL;


@end

@implementation WKProjectPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUIAndFrame];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)updateCellWithTitle:(NSString *)title detail:(NSString *)detail {
    self.titleLabel.text = title;
    self.detailL.text = detail;

}



- (void)configureUIAndFrame {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailL];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(30));
        make.width.equalTo(self.titleLabel.mas_width);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(30));
        make.width.equalTo(self.detailL.mas_width);
    }];
}


#pragma mark - get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = DetailTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = SPICAL_DETAIL_FONT(14.0f);
    }
    return _titleLabel;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = TitleTextColor;
        _detailL.textAlignment = NSTextAlignmentRight;
        _detailL.font = SPICAL_FONT(14.0f);
    }
    return _detailL;
}

@end
