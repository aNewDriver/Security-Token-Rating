//
//  WKTopicDisCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKTopicDisCell.h"

@interface WKTopicDisCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UILabel *countL;

@end

@implementation WKTopicDisCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
    }
    return self;
}


- (void)updateCellWithModel:(WKPostInfoModel *)model {
    self.titleL.text = model.title.rendered;
    
    NSString *metaStr = model.content.rendered;
    NSArray *subStrArray = [metaStr componentsSeparatedByString:@"\n"];
    NSArray *resultArray = [self stringArraySub:subStrArray startChar:@">" endChar:@"</"];
    model.resultContentArray = resultArray;
    
    NSString *backIconStr = [resultArray[1] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
    NSString *backIconUrl = [backIconStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
    NSString *backIconResult = [backIconUrl substringWithRange:NSMakeRange(1, backIconUrl.length - 3)];
    
    NSString *iconStr = [resultArray[2] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
    NSString *iconUrl = [iconStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
    NSString *iconResult = [iconUrl substringWithRange:NSMakeRange(1, iconUrl.length - 3)];
    
    
    self.detailL.attributedText = [resultArray[0] attStrEncodeWithFont:SPICAL_DETAIL_FONT(12.0f) textColor:RGBCOLOR(153, 153, 153) textAlignment:NSTextAlignmentLeft];
    if (!model.disscussModel) {
        model.disscussModel = [[WKDiscussModel alloc] init];
    }
    
    model.disscussModel = [[WKDiscussModel alloc] init];
    model.disscussModel.titleStr = model.title.rendered;
    model.disscussModel.detailStr = resultArray[0];
    model.disscussModel.backIconUrl = [backIconResult stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.disscussModel.iconUrl = [iconResult stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (resultArray.count > 2) {
        NSString *imageStr = [resultArray[3] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
        NSString *imageUrl = [imageStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
        NSString *imageResult = [imageUrl substringWithRange:NSMakeRange(1, imageUrl.length - 3)];
        
        [self.imageV sd_setImageWithURL:[imageResult stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
    }
}

-(NSString*)URLDecodedString:(NSString*)str

{
    NSString* decodedString = (__bridge_transfer NSString*) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
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
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.imageV];
    [self.backView addSubview:self.titleL];
    [self.backView addSubview:self.detailL];
//    [self.backView addSubview:self.countL];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5.0f);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0f);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(10.0f);
        make.top.equalTo(self.backView).offset(15.0f);
        make.height.equalTo(self.titleL.mas_height);
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-10.0f);
        make.top.equalTo(self.titleL.mas_bottom).offset(10.0f);
        make.width.equalTo(@90.0f);
        make.height.equalTo(@60.0f);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-20.0f);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageV.mas_left).offset(-10.0f);
        make.height.equalTo(self.detailL.mas_height);
        make.top.equalTo(self.titleL.mas_bottom).offset(10.0f);
        make.left.equalTo(self.backView).offset(10.0f);
    }];
//    [self.countL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backView).offset(10.0f);
//        make.width.equalTo(@200.0f);
//        make.height.equalTo(@15.0f);
//        make.top.equalTo(self.detailL.mas_bottom).offset(15.0f);
//       
//    }];
    
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
        _imageV.layer.cornerRadius = 4.0f;
        _imageV.layer.masksToBounds = YES;
    }
    return _imageV;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = RGBACOLOR(66, 66, 66, 1);
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = SPICAL_FONT(16.0f);
        _titleL.text = @"In your opinion, what is the best faction to play in STO and why?";
        _titleL.numberOfLines = 2;
    }
    return _titleL;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = DetailTextColor;
        _detailL.textAlignment = NSTextAlignmentLeft;
        _detailL.font = SPICAL_FONT(12.0f);
        _detailL.numberOfLines = 4;
        _detailL.text = @"不少从业者认为STO肩负着“繁荣区块链”的重任，然而也有人不相信那些非区块链行业的资产标的加上…不少从业者认为STO肩负着“繁荣区块链”的重任，然而也有人不相信那些非区块链行业的资产标的加上…不少从业者认为STO肩负着“繁荣区块链”的重任，然而也有人不相信那些非区块链行业的资产标的加上…不少从业者认为STO肩负着“繁荣区块链”的重任，然而也有人不相信那些非区块链行业的资产标的加上…";
    }
    return _detailL;
}

- (UILabel *)countL {
    if (!_countL) {
        _countL = [[UILabel alloc] init];
        _countL.textColor = RGBACOLOR(170, 170, 170, 1);
        _countL.textAlignment = NSTextAlignmentLeft;
        _countL.font = SPICAL_FONT(10.0f);
        NSString *views = WKGetStringWithKeyFromTable(@"views", nil);
        NSString *comments = WKGetStringWithKeyFromTable(@"comments", nil);
        _countL.text = [NSString stringWithFormat:@"190%@         30%@", views, comments];;
    }
    return _countL;
}

@end
