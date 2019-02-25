//
//  WKDisCollectionViewCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKDisCollectionViewCell.h"

@interface WKDisCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *detailL;


@end

@implementation WKDisCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithModel:(WKPostInfoModel *)model {
    
    NSString *str111 = @"Project Discussion";
    
    NSString *resS = [model.title.rendered stringByAppendingString:[NSString stringWithFormat:@"\n%@", str111]];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:resS];
    
    [attStr addAttributes:@{NSFontAttributeName : SPICAL_FONT(14)} range:NSMakeRange(0, model.title.rendered.length)];
    [attStr addAttributes:@{NSFontAttributeName : SPICAL_FONT(12)} range:NSMakeRange(model.title.rendered.length + 1, str111.length)];
    
    self.nameL.attributedText = attStr;;
    
    
    self.detailL.attributedText = [model.disscussModel.detailStr attStrEncodeWithFont:SPICAL_DETAIL_FONT(12.0f) textColor:RGBCOLOR(153, 153, 153) textAlignment:NSTextAlignmentCenter];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.disscussModel.backIconUrl]];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.disscussModel.iconUrl]];
    
    
//    NSString *metaStr = model.content.rendered;
//    NSArray *subStrArray = [metaStr componentsSeparatedByString:@"\n"];
//    NSArray *resultArray = [self stringArraySub:subStrArray startChar:@">" endChar:@"</"];
//    model.resultContentArray = resultArray;
    
//    self.detailL.text = resultArray[0];
//
//    NSString *backImageStr = [resultArray[1] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
//    NSString *backImaUrl = [backImageStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
//    NSString *backResS = [backImaUrl substringWithRange:NSMakeRange(1, backImaUrl.length - 3)];
//
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[backResS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        NSLog(@"%@",error);
//
//    }];
//
//
//    NSString *iconImageStr = [resultArray[2] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
//    NSString *iconImaUrl = [iconImageStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
//    NSString *iconResS = [iconImaUrl substringWithRange:NSMakeRange(1, iconImaUrl.length - 3)];
//    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:iconResS] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageAllowInvalidSSLCertificates];
    
    
}

- (NSArray *)stringArraySub:(NSArray *)array startChar:(NSString *)startChar endChar:(NSString *)endChar{
    NSMutableArray *resultArray = @[].mutableCopy;
    for (NSString *string in array) {
        if (![string isEmpty]) {
            [resultArray addObject:[string subStrAtCharsRangeWithStartChar:startChar endChar:endChar]];
        }
    }
    return resultArray.copy;
}


- (void)configureUIAndFrame {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.imageV];
    [self.backView addSubview:self.iconImage];
    [self.backView addSubview:self.nameL];
    [self.backView addSubview:self.detailL];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.bottom.top.equalTo(self.contentView);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.shadowView);
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.contentView);
        make.height.equalTo(@(35.0f));
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(6.0f);
        make.height.width.equalTo(@40.0f);
    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage.mas_bottom).offset(6.0f);
        make.centerX.equalTo(self.backView.mas_centerX);
        make.height.equalTo(self.nameL.mas_height);
        make.width.equalTo(self.backView);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(5.0f);
        make.right.equalTo(self.backView.mas_right).offset(-5.0f);
        make.top.equalTo(self.nameL.mas_bottom).offset(10.0f);
        make.height.equalTo(self.detailL.mas_height);
    }];
}

#pragma mark - get

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor whiteColor];
        _shadowView.layer.cornerRadius = 5.0f;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowColor = RGBACOLOR(98, 98, 98, 0.12).CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _shadowView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5.0f;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor clearColor];
        _imageV.layer.masksToBounds = YES;
    }
    return _imageV;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = [UIColor clearColor];
    }
    return _iconImage;
}


- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.textColor = RGBACOLOR(66, 66, 66, 1);
        _nameL.textAlignment = NSTextAlignmentCenter;
        _nameL.font = SPICAL_FONT(14.0f);
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
        _detailL.font = SPICAL_FONT(12.0f);
        _detailL.text = @"SPiCE provides exposure to the massive growth of the Blockchain /Tokenization…";
        _detailL.numberOfLines = 4;
    }
    return _detailL;
}

@end
