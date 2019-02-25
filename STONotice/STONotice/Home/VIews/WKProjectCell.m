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
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *priceL;
@property (nonatomic, strong) UILabel *priceDetailL;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *issuedL;

@end

@implementation WKProjectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithModel:(WKPostInfoModel *)model {
    self.nameL.text = model.title.rendered;

    NSString *content = model.content.rendered;
    
    NSArray *array = [content componentsSeparatedByString:@"\n"];
    
    NSArray *resultA = [self stringArraySub:array startChar:@">" endChar:@"</"];
    
    if ([model.categories containsObject:@(WKPostCategary_unIssuedProject)]) {
        self.issuedL.hidden = YES;
        self.iconImage.hidden = YES;
    } else {
        self.issuedL.hidden = NO;
        self.iconImage.hidden = NO;
    }
    
    model.resultContentArray = resultA;
    if (resultA) {
        
        NSAttributedString *price = [resultA[5] getAttributedWithLineSpace:3.0f kern:1.0f font:SYSTEM_NORMAL_NAME_FONT(DINTextName, 22.0f)];
        
        self.priceL.attributedText = price;
        
        NSString *tag = resultA[6];
        NSArray *tags = [tag componentsSeparatedByString:@";"];
        
        [self configureTagsWithArray:tags];

        
        
        NSString *imaStr = [resultA[2] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
        NSString *imaUrl = [imaStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
        NSString *resS = [imaUrl substringWithRange:NSMakeRange(1, imaUrl.length - 3)];
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:resS] placeholderImage:[UIImage imageNamed:@""] ];
        [self loadDataModelWithWithModel:model resultA:resultA];

    }
}

- (void)loadDataModelWithWithModel:(WKPostInfoModel *)model resultA:(NSArray *)resultA { //!< 装载数据
   
    if (!model.disscussModel) {
        model.disscussModel = [[WKDiscussModel alloc] init];
    }
    
    
    
    NSString *backIconStr = [resultA[0] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
    NSString *backIconUrl = [backIconStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
    NSString *backResult = [backIconUrl substringWithRange:NSMakeRange(1, backIconUrl.length - 3)];
    
    NSString *iconStr = [resultA[1] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
    NSString *iconUrl = [iconStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
    NSString *iconResult = [iconUrl substringWithRange:NSMakeRange(1, iconUrl.length - 3)];
    
    model.disscussModel.backIconUrl = [backResult stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.disscussModel.iconUrl = [iconResult stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.disscussModel.titleStr = resultA[3];
    model.disscussModel.detailStr = resultA[4];
    
    
    if (!model.detailModel) {
        model.detailModel = [[WKProjectDetailIofo alloc] init];
        
    }
    NSString *imaStr = [resultA[2] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
    NSString *imaUrl = [imaStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
    NSString *resS = [imaUrl substringWithRange:NSMakeRange(1, imaUrl.length - 3)];
    
    model.detailModel.imageUrl = [resS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSString *tag = resultA[6];
    NSArray *tags = [tag componentsSeparatedByString:@";"];
    model.detailModel.tags = tags;
    
    NSString *categoriesStr = resultA[7];
    NSArray *categories = [categoriesStr componentsSeparatedByString:@";"];
    model.detailModel.categories = categories;
    
    NSString *summS = resultA[8];
    NSArray *summA = [summS componentsSeparatedByString:@";"];
    model.detailModel.summarys = summA;
    
    model.detailModel.projectSummary = resultA[9];
    
    if (resultA.count > 9) {
        model.detailModel.teamMember = @[].mutableCopy;
        for (int i = 10; i < resultA.count; i++) {
            NSString *str = resultA[i];
            NSArray *arr = [str componentsSeparatedByString:@"||"];
            WKProjectTeamMember *tModel = [[WKProjectTeamMember alloc] init];
            tModel.name = arr[0];
            tModel.linkUrl = arr[1];
            tModel.desc = arr[2];
            [model.detailModel.teamMember addObject:tModel];
        }
    }
    
    model.haveLoad = YES;
    
    [[WKAllProjectModelManager sharedManager] updateModel:model];
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




#pragma mark - method

- (void)configureUIAndFrame {
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.imageV];
    [self.backView addSubview:self.nameL];
    [self.backView addSubview:self.priceL];
    [self.backView addSubview:self.priceDetailL];
    [self.backView addSubview:self.iconImage];
    [self.iconImage addSubview:self.issuedL];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5.0f);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.height.equalTo(@(100.0f));
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0f);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.right.bottom.equalTo(self.shadowView);
    }];
    
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(15.0f);
        make.top.equalTo(self.backView).offset(25.0f);
        make.width.height.equalTo(@25.0f);
    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(10.0f);
        make.centerY.equalTo(self.imageV.mas_centerY);
        make.height.equalTo(@20.0f);
        make.width.equalTo(self.nameL.mas_width);
    }];
    
    [self.priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
        make.width.equalTo(self.priceL.mas_width);
        make.height.equalTo(self.priceL.mas_height);
        make.top.equalTo(self.nameL);
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.backView);
        make.width.equalTo(@45.0f);
        make.height.equalTo(@16.0f);
    }];
    [self.issuedL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.iconImage);
    }];
    [self.priceDetailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
        make.width.equalTo(self.priceL.mas_width);
        make.height.equalTo(@15.0f);
        make.top.equalTo(self.priceL.mas_bottom).offset(13.0f);
    }];

}

- (void)configureTagsWithArray:(NSArray <NSString *> *)array {
    
    if (!array || array.count == 0) {
        return;
    }
    CGFloat left = 15.0f;
    for (NSUInteger i = 0; i < array.count; i++) {
        NSString *tag = array[i];
        CGSize size = [tag sizeWithAttributes:@{NSFontAttributeName : SPICAL_FONT(11.0f)}];
        CGFloat width = size.width + 12.0f;
        
        UILabel *tagL = [[UILabel alloc] init];
        tagL.textColor = RGBCOLOR(151, 151, 151);
        tagL.backgroundColor = BACKGROUND_COLOR;
        tagL.textAlignment = NSTextAlignmentCenter;
        tagL.font = SPICAL_DETAIL_FONT(11.0f);
        tagL.layer.cornerRadius = 2.0f;
        tagL.layer.masksToBounds = YES;
        tagL.text = tag;
        [self.backView addSubview:tagL];
        
        [tagL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left));
            make.top.equalTo(self.priceDetailL);
            make.width.equalTo(@(width));
            make.height.equalTo(@18.0f);
        }];
        left = width + 6.0f + left;
    }
    
}

#pragma mark - get

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor whiteColor];
        _shadowView.layer.cornerRadius = 4.0f;
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
        _backView.layer.cornerRadius = 4.0f;
        _backView.layer.shadowOpacity = 1;
        _backView.layer.masksToBounds = YES;
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
        _nameL.font = SPICAL_FONT(18.0f);
        _nameL.text = @"SpiceVC";
    }
    return _nameL;
}

- (UILabel *)priceL {
    if (!_priceL) {
        _priceL = [[UILabel alloc] init];
        _priceL.textColor = RGBACOLOR(66, 66, 66, 1);
        _priceL.textAlignment = NSTextAlignmentLeft;
        _priceL.font = SYSTEM_NORMAL_NAME_FONT(DINTextName, 22.0f);
        _priceL.text = @"2,000,000";
    }
    return _priceL;
}

- (UILabel *)issuedL {
    if (!_issuedL) {
        _issuedL = [[UILabel alloc] init];
        _issuedL.textColor = [UIColor whiteColor];
        _issuedL.textAlignment = NSTextAlignmentCenter;
        _issuedL.font = SPICAL_FONT(10.0f);
        _issuedL.text = WKGetStringWithKeyFromTable(@"issuedText", nil);
    }
    return _issuedL;
}
- (UILabel *)priceDetailL {
    if (!_priceDetailL) {
        _priceDetailL = [[UILabel alloc] init];
        _priceDetailL.textColor = RGBACOLOR(170, 170, 170, 1);
        _priceDetailL.textAlignment = NSTextAlignmentRight;
        _priceDetailL.font = SPICAL_DETAIL_FONT(11.0f);
        _priceDetailL.text = WKGetStringWithKeyFromTable(@"totalSupply", nil);
    }
    return _priceDetailL;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.layer.masksToBounds = YES;
        _iconImage.backgroundColor = [UIColor clearColor];
        _iconImage.image = [UIImage imageNamed:@"issuedIcon"];
    }
    return _iconImage;
}


@end
