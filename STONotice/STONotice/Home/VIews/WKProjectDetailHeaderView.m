//
//  WKProjectDetailHeaderView.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKProjectDetailHeaderView.h"
#import "WKCustomSegmentView.h"

@interface WKProjectDetailHeaderView ()

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *totalL;
@property (nonatomic, strong) UILabel *categoryL;
@property (nonatomic, strong) UILabel *ratingL;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) WKCustomSegmentView *segment;

@end

@implementation WKProjectDetailHeaderView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAndFrame];
    }
    return self;
}


- (void)updateUIWithModel:(WKPostInfoModel *)model {
    [self.header sd_setImageWithURL:[NSURL URLWithString:model.detailModel.imageUrl]];
    self.nameL.text = model.title.rendered;
    
    NSString *totalP = model.detailModel.categories[0];
    NSString *subStr = WKGetStringWithKeyFromTable(@"totalSupply", nil);
    NSString *resP = [subStr stringByAppendingString:[NSString stringWithFormat:@"\n%@", totalP]];
    self.totalL.attributedText = [self attstrWithStr:resP range1:NSMakeRange(0, subStr.length) rang1TextColor:nil range2:NSMakeRange(subStr.length + 1, resP.length - subStr.length - 1) range2TextColor:nil];
    
    NSString *cate = model.detailModel.categories[1];
    NSString *cateStr = WKGetStringWithKeyFromTable(@"category", nil);
    NSString *resC = [cateStr stringByAppendingString:[NSString stringWithFormat:@"\n%@", cate]];
    self.categoryL.attributedText = [self attstrWithStr:resC range1:NSMakeRange(0, cateStr.length) rang1TextColor:nil range2:NSMakeRange(cateStr.length + 1, resC.length - cateStr.length - 1) range2TextColor:nil];

    NSString *rat = model.detailModel.categories[2];
    NSString *ratStr = WKGetStringWithKeyFromTable(@"rating", nil);
    NSString *resR = [ratStr stringByAppendingString:[NSString stringWithFormat:@"\n%@", rat]];
    self.ratingL.attributedText = [self attstrWithStr:resR range1:NSMakeRange(0, ratStr.length) rang1TextColor:nil range2:NSMakeRange(ratStr.length + 1, resR.length - ratStr.length - 1) range2TextColor:LoginRegisterBlue];
    
}


#pragma mark - configure
- (void)configureUIAndFrame {
    [self addSubview:self.header];
    [self addSubview:self.nameL];
    [self addSubview:self.totalL];
    [self addSubview:self.categoryL];
    [self addSubview:self.ratingL];
    [self addSubview:self.bottomLine];
    [self addSubview:self.segment];
    
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.top.equalTo(self).offset(20.0f);
        make.width.height.equalTo(@(32));
    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.header);
        make.left.equalTo(self.header.mas_right).offset(10);
        make.height.equalTo(@20.0f);
        make.width.equalTo(self.nameL.mas_width);
    }];
    
    
    [self.totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.width.equalTo(self.totalL.mas_width);
        make.height.equalTo(@43.0f);
        make.top.equalTo(self.header.mas_bottom).offset(20.0f);
    }];
    
    UIView *line1 = [self createLineWithLabel:self.totalL atIndex:0];
    
    [self.categoryL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1).offset(15.0f);
        make.width.equalTo(self.categoryL.mas_width);
        make.height.equalTo(@43.0f);
        make.top.equalTo(self.totalL);
    }];
    
    UIView *line2 = [self createLineWithLabel:self.categoryL atIndex:1];
    
    [self.ratingL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2).offset(15.0f);
        make.width.equalTo(self.ratingL.mas_width);
        make.height.equalTo(@43.0f);
        make.top.equalTo(self.totalL);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.totalL.mas_bottom).offset(20);
        make.height.equalTo(@(10));
    }];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@(50));
        make.top.equalTo(self.bottomLine.mas_bottom);
    }];
    
}

- (UIView *)createLineWithLabel:(UILabel *)label atIndex:(NSUInteger)index{
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BACKGROUND_COLOR;
    CGFloat left = 0;
    if (index == 0) {
        left = FRAME_FLOAT(143.0f);
    } else {
        left = FRAME_FLOAT(287.0f);
    }
    line.frame = CGRectMake(left, 71.0f, 1.0f, 43.0f);
    [self addSubview:line];
    return line;
}

#pragma mark - get

- (WKCustomSegmentView *)segment {
    if (!_segment) {
        NSString *summary = WKGetStringWithKeyFromTable(@"summary", nil);
        NSString *teamMember = WKGetStringWithKeyFromTable(@"teamMember", nil);
        NSString *discussion = WKGetStringWithKeyFromTable(@"discussion", nil);

        _segment = [[WKCustomSegmentView alloc] initWithSegmentTitles:@[summary, teamMember, discussion]];
        __weak typeof(self) weakSelf = self;
        
        _segment.segmentCilck = ^(NSUInteger index) {
            
            if (weakSelf.segmentClick) {
                weakSelf.segmentClick(index);
            }
        };
    }
    return _segment;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = BACKGROUND_COLOR;
    }
    return _bottomLine;
}

- (UIImageView *)header {
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.backgroundColor = [UIColor grayColor];
        _header.layer.cornerRadius = 16.0f;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.backgroundColor = [UIColor clearColor];
        _nameL.font = SPICAL_FONT(18);
        _nameL.text = @"SpiceVC";
    }
    return _nameL;
}


- (UILabel *)totalL {
    if (!_totalL) {
        _totalL = [[UILabel alloc] init];
        _totalL.backgroundColor = [UIColor clearColor];
        NSString *subStr = WKGetStringWithKeyFromTable(@"totalSupply", nil);
        NSString *str =[subStr stringByAppendingString:@"\n1,000,000"];
        _totalL.attributedText = [self attstrWithStr:str range1:NSMakeRange(0, subStr.length) rang1TextColor:nil range2:NSMakeRange(subStr.length + 1, str.length - subStr.length - 1) range2TextColor:nil];
        _totalL.numberOfLines = 2;

    }
    return _totalL;
}

- (UILabel *)categoryL {
    if (!_categoryL) {
        _categoryL = [[UILabel alloc] init];
        _categoryL.backgroundColor = [UIColor clearColor];
        NSString *subStr = WKGetStringWithKeyFromTable(@"category", nil);
        NSString *str =[subStr stringByAppendingString:@"\nReal Estate"];
        _categoryL.attributedText = [self attstrWithStr:str range1:NSMakeRange(0, subStr.length) rang1TextColor:nil range2:NSMakeRange(subStr.length + 1, str.length - subStr.length - 1) range2TextColor:nil];
        _categoryL.numberOfLines = 2;

        
    }
    return _categoryL;
}

- (UILabel *)ratingL {
    if (!_ratingL) {
        _ratingL = [[UILabel alloc] init];
        _ratingL.backgroundColor = [UIColor clearColor];
        _ratingL.numberOfLines = 2;
        NSString *subStr = WKGetStringWithKeyFromTable(@"rating", nil);
        NSString *str =[subStr stringByAppendingString:@"\nC+"];
        _ratingL.attributedText = [self attstrWithStr:str range1:NSMakeRange(0, subStr.length) rang1TextColor:nil range2:NSMakeRange(subStr.length + 1, str.length - subStr.length - 1) range2TextColor:LoginRegisterBlue];
    }
    return _ratingL;
}

- (NSMutableAttributedString *)attstrWithStr:(NSString *)str
                                      range1:(NSRange)rang1
                              rang1TextColor:(UIColor *)rang1TextColor
                                      range2:(NSRange)range2
                             range2TextColor:(UIColor *)range2TextColor {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    if (rang1TextColor == nil) {
        rang1TextColor = RGBCOLOR(170, 170, 170);
    }
    
    if (range2TextColor == nil) {
        range2TextColor = TitleTextColor;
    }
    
    [attStr addAttributes:@{NSForegroundColorAttributeName : rang1TextColor, NSFontAttributeName : SPICAL_DETAIL_FONT(10)} range:rang1];
    [attStr addAttributes:@{NSForegroundColorAttributeName : range2TextColor, NSFontAttributeName : SPICAL_FONT(16.0f)} range:range2];
    
    
    [attStr adjustmentLineSpaceWithSpace:5];
    
    return attStr;
}

@end
