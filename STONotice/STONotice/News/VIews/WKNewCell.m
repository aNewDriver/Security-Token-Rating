//
//  WKNewCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKNewCell.h"

@interface WKNewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *line;

@end

@implementation WKNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithModel:(WKPostInfoModel *)model {
    NSString *title = [model.title.rendered subStrAtCharsRangeWithStartChar:@"<p>" endChar:@"</p>"];
    NSAttributedString *attstr = [title attStrEncodeWithFont:SPICAL_FONT(16.0f) textColor:TitleTextColor textAlignment:NSTextAlignmentLeft];
    self.titleLabel.attributedText = attstr;
    NSString *detailStr = model.content.rendered;
    NSArray *array = [detailStr componentsSeparatedByString:@"\n"];
    NSArray *detailStrArray = [self stringArraySub:array startChar:@">" endChar:@"</"];
    model.resultContentArray = detailStrArray;
    self.detailLabel.text = detailStrArray[0];
    
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

#pragma mark - configure

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.line];
    self.titleLabel.frame = CGRectMake(15, 15, 215 * SCREENSCALE, 60);
    self.detailLabel.frame = CGRectMake(15, 81 + 15, 215 * SCREENSCALE, 14.0f);
    self.line.frame = CGRectMake(15, CGRectGetMaxY(self.detailLabel.frame) + 10, SCREEN_WIDTH - 30, 1.0f);
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10.0f);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(116 * SCREENSCALE));
        make.height.equalTo(@(80 * SCREENSCALE));
    }];
}




#pragma mark - get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = SPICAL_FONT(16.0f);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = TitleTextColor;
        _titleLabel.text = @"标题标题标题标题标题标题标题标题标题标题标题标题标题";
        _titleLabel.numberOfLines = 3;
    }
    return _titleLabel;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = SPICAL_DETAIL_FONT(12.0f);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textColor = RGBCOLOR(170, 170, 170);
        _detailLabel.text = @"Bankorus 2小时前";
    }
    return _detailLabel;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = BACKGROUND_COLOR;
        _imageV.layer.cornerRadius = 5.0f;
        _imageV.layer.masksToBounds = YES;
    }
    return _imageV;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBCOLOR(241, 241, 241);
    }
    return _line;
}


@end
