//
//  WKDiscussCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKDiscussCell.h"
#import "WKHomeManager.h"

@interface WKDiscussCell ()

@property (nonatomic, strong) UIImageView *headerV;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UILabel *line;

@end

@implementation WKDiscussCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithModel:(WKCommentModel *)model {
    self.nameL.text = model.author_name;
    self.timeL.text = [model.date containsString:@"T"] ? [model.date stringByReplacingOccurrencesOfString:@"T" withString:@"  "] : model.date;
    if ([model.content.rendered containsString:@"<p>" ] && [model.content.rendered containsString:@"</p>" ]) {
        NSString *str = [model.content.rendered subStrAtCharsRangeWithStartChar:@"<p>" endChar:@"</p>"];
        self.detailL.attributedText = [str attStrEncodeWithFont:SPICAL_DETAIL_FONT(14.0f) textColor:DetailTextColor textAlignment:NSTextAlignmentLeft];

    } else {
        NSString *str = model.content.rendered;
        self.detailL.attributedText = [str attStrEncodeWithFont:SPICAL_DETAIL_FONT(14.0f) textColor:DetailTextColor textAlignment:NSTextAlignmentLeft];
    }
    
    [self getUserInfoWithUserId:model.author model:model];
    
}


- (void)getUserInfoWithUserId:(NSString *)userId model:(WKCommentModel *)model{
    
    if (model.simple_local_avatar != nil) {
        [self.headerV sd_setImageWithURL:[NSURL URLWithString:model.simple_local_avatar.big] placeholderImage:[UIImage imageNamed:@"defaultHeaderImage"]];
        return;
    }
    
    
    [WKHomeManager getUserInfoWithUserId:userId success:^(id  _Nonnull response) {
        
        WKCommentModel *model1 = [WKCommentModel modelWithDictionary:response];
        model.simple_local_avatar = model1.simple_local_avatar;
        [self.headerV sd_setImageWithURL:[NSURL URLWithString:model.simple_local_avatar.big] placeholderImage:[UIImage imageNamed:@"defaultHeaderImage"]];
        

    } fail:^(NSError * _Nonnull error) {
        NSLog(@"error = %@", error.description);
        
    }];
}


#pragma mark - configure

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.headerV];
    [self.contentView addSubview:self.nameL];
    [self.contentView addSubview:self.detailL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.line];
    
    [self.headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15.0f);
        make.height.width.equalTo(@(30.0f));
    }];
    
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerV.mas_right).offset(10.0f);
        make.centerY.equalTo(self.headerV);
        make.height.equalTo(self.nameL.mas_height);
        make.width.equalTo(self.nameL.mas_height);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameL.mas_left);
        make.top.equalTo(self.headerV.mas_bottom).offset(6.0f);
        make.height.equalTo(self.detailL.mas_height);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0f);
    }];
    
    [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailL.mas_left);
        make.top.equalTo(self.detailL.mas_bottom).offset(10.0f);
        make.height.equalTo(self.timeL.mas_height);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0f);
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.top.equalTo(self.timeL.mas_bottom).offset(13.0f);
        make.height.equalTo(@(0.5f));
    }];

}

#pragma mark - get

- (UIImageView *)headerV {
    if (!_headerV) {
        _headerV = [[UIImageView alloc] init];
        _headerV.backgroundColor = [UIColor clearColor];
        _headerV.layer.cornerRadius = 15.0f;
        _headerV.layer.masksToBounds = YES;
        _headerV.image = [UIImage imageNamed:@"defaultHeaderImage"];
    }
    return _headerV;
}

- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.textColor = TitleTextColor;
        _nameL.font = SPICAL_FONT(14.0f);
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.text = @"马云";
    }
    return _nameL;
}

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = DetailTextColor;
        _detailL.font = SPICAL_DETAIL_FONT(14.0f);
        _detailL.numberOfLines = 0;
        _detailL.textAlignment = NSTextAlignmentLeft;
        _detailL.text = @"赛季会发货时覅哈是否hi傻了客服哈师大黄金时代赛季会发货时覅哈是否hi傻了客服哈师大黄金时代赛季会发货时覅哈是否hi傻了客服哈师大黄金时代赛季会发货时覅哈是否hi傻了客服哈师大黄金时代";
    }
    return _detailL;
}

- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [[UILabel alloc] init];
        _timeL.textColor = RGBCOLOR(192, 192, 192);
        _timeL.font = SPICAL_DETAIL_FONT(12.0f);
        _timeL.textAlignment = NSTextAlignmentLeft;
        _timeL.text = @"10分钟前";
    }
    return _timeL;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBCOLOR(241, 241, 241);
    }
    return _line;
}

@end
