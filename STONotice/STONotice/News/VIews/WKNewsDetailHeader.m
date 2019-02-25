//
//  WKNewsDetailHeader.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKNewsDetailHeader.h"

@interface WKNewsDetailHeader ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *incL;
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation WKNewsDetailHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateUIWithModel:(WKPostInfoModel *)model  {
    self.titleL.text = [model.title.rendered subStrAtCharsRangeWithStartChar:@"<p>" endChar:@"</p>"];
    NSString *detailStr = model.content.rendered;
    NSArray *array = [detailStr componentsSeparatedByString:@"\n"];
    NSArray *detailStrArray = [self stringArraySub:array startChar:@">" endChar:@"</"];
    model.resultContentArray = detailStrArray;
    self.incL.text = detailStrArray[0];
    
    NSString *imaStr = [detailStrArray[1] subStrAtCharsRangeWithStartChar:@"<img" endChar:@"/>"];
    NSString *imaUrl = [imaStr subStrAtCharsRangeWithStartChar:@"src=" endChar:@"alt="];
    NSString *resS = [imaUrl substringWithRange:NSMakeRange(1, imaUrl.length - 3)];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:resS] ];
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
    [self addSubview:self.titleL];
    [self addSubview:self.line];
    [self addSubview:self.incL];
    [self addSubview:self.imageV];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.top.equalTo(self).offset(20.0f);
        make.height.mas_equalTo(46.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleL);
        make.top.equalTo(self.titleL.mas_bottom).offset(20.0f);
        make.height.mas_equalTo(1.0f);
    }];
    
    [self.incL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line);
        make.top.equalTo(self.line.mas_bottom).offset(10.0f);
        make.height.mas_equalTo(14.0f);
        make.width.equalTo(self.incL.mas_width);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.line);
        make.top.equalTo(self.incL.mas_bottom).offset(10.0f);
        make.height.mas_equalTo(176.0f);
    }];

}

#pragma mark - get

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.textColor = TitleTextColor;
        _titleL.font = SPICAL_FONT(16.0f);
        _titleL.text = @"Investor Rights and Legal Risks Might Make STOs the Future of Funding";
        _titleL.numberOfLines = 2;
    }
    return _titleL;
}

- (UILabel *)incL {
    if (!_incL) {
        _incL = [[UILabel alloc] init];
        _incL.textAlignment = NSTextAlignmentLeft;
        _incL.textColor = RGBCOLOR(170, 170, 170);
        _incL.font = SPICAL_DETAIL_FONT(14.0f);
        _incL.text = @"Bankorus";
        
    }
    return _incL;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BACKGROUND_COLOR;
    }
    return _line;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = BACKGROUND_COLOR;
        _imageV.layer.cornerRadius = 5.0f;
        _imageV.layer.masksToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageV;
}


@end
