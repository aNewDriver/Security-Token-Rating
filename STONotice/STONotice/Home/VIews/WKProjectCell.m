//
//  WKProjectCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKProjectCell.h"

@interface WKProjectCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *priceL;
@property (nonatomic, strong) UILabel *priceDetailL;

@end

@implementation WKProjectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
        [self configureTagsWithArray:@[@"Real", @"C+", @"Reg", @"Medium Risk"]];
    }
    return self;
}





#pragma mark - method

- (void)configureUIAndFrame {
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.imageV];
    [self.backView addSubview:self.nameL];
    [self.backView addSubview:self.priceL];
    [self.backView addSubview:self.priceDetailL];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5.0f);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.height.equalTo(@(100.0f));
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0f);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(18.0f);
        make.top.equalTo(self.backView).offset(20.0f);
        make.width.height.equalTo(@25.0f);
    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(10.0f);
        make.top.equalTo(self.imageV);
        make.height.equalTo(@20.0f);
        make.width.equalTo(self.nameL.mas_width);
    }];
    
    [self.priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
        make.width.equalTo(@90.0f);
        make.height.equalTo(self.priceL.mas_height);
        make.top.equalTo(self.nameL);
    }];
    [self.priceDetailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
        make.width.equalTo(self.priceL.mas_width);
        make.height.equalTo(@15.0f);
        make.top.equalTo(self.priceL.mas_bottom).offset(5.0f);
    }];

}

- (void)configureTagsWithArray:(NSArray <NSString *> *)array {
    
    if (!array || array.count == 0) {
        return;
    }
    CGFloat left = 15.0f;
    for (NSUInteger i = 0; i < array.count; i++) {
        NSString *tag = array[i];
        CGSize size = [tag sizeWithAttributes:@{NSFontAttributeName : SYSTEM_NORMAL_FONT(9.0f)}];
        CGFloat width = size.width + 10.0f;
        
        UILabel *tagL = [[UILabel alloc] init];
        tagL.textColor = RGBCOLOR(151, 151, 151);
        tagL.backgroundColor = BACKGROUND_COLOR;
        tagL.textAlignment = NSTextAlignmentCenter;
        tagL.font = SYSTEM_NORMAL_FONT(9.0f);
        tagL.layer.cornerRadius = 2.0f;
        tagL.layer.masksToBounds = YES;
        tagL.text = tag;
        [self.backView addSubview:tagL];
        
        [tagL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left));
            make.top.equalTo(self.priceDetailL);
            make.width.equalTo(@(width));
            make.height.equalTo(@10.0f);
        }];
        left = width + 5.0f + left;
    }
    
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
        _imageV.layer.cornerRadius = 25.0f / 2 ;
    }
    return _imageV;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.textColor = RGBACOLOR(66, 66, 66, 1);
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = SYSTEM_NORMAL_FONT(16.0f);
        _nameL.text = @"SpiceVC";
    }
    return _nameL;
}

- (UILabel *)priceL {
    if (!_priceL) {
        _priceL = [[UILabel alloc] init];
        _priceL.textColor = RGBACOLOR(66, 66, 66, 1);
        _priceL.textAlignment = NSTextAlignmentLeft;
        _priceL.font = SYSTEM_NORMAL_FONT(20.0f);
        _priceL.numberOfLines = 2;
        _priceL.text = @"2,000,000";
    }
    return _priceL;
}

- (UILabel *)priceDetailL {
    if (!_priceDetailL) {
        _priceDetailL = [[UILabel alloc] init];
        _priceDetailL.textColor = RGBACOLOR(170, 170, 170, 1);
        _priceDetailL.textAlignment = NSTextAlignmentRight;
        _priceDetailL.font = SYSTEM_NORMAL_FONT(9.0f);
        _priceDetailL.text = @"Total Supply";
    }
    return _priceDetailL;
}


@end
