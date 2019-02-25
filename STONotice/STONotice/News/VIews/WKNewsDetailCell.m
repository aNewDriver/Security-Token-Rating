//
//  WKNewsDetailCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKNewsDetailCell.h"

@interface WKNewsDetailCell ()

@property (nonatomic, strong) UILabel *detailL;

@end

@implementation WKNewsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithModel:(WKPostInfoModel *)model formBanner:(BOOL)formBanner {
//    NSString *resultStr = @"";
    NSMutableAttributedString *resAtt = [[NSMutableAttributedString alloc] init];
    if (model.resultContentArray.count > 1) {
        int i = formBanner ? 3 : 2;
        for (i; i < model.resultContentArray.count; i++) {
            NSString *str = model.resultContentArray[i];
            NSMutableAttributedString *attStr = [str attStrEncodeWithFont:SPICAL_DETAIL_FONT(14.0f) textColor:DetailTextColor textAlignment:NSTextAlignmentLeft].mutableCopy;
            [attStr adjustmentLineSpaceWithSpace:5.0f];
            [attStr appendString:@"\n\n"];
            [resAtt appendAttributedString:attStr];
        }
    }
    self.detailL.attributedText = resAtt;
}

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.detailL];
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.top.equalTo(self.contentView).offset(23.0f);
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.height.equalTo(self.detailL.mas_height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15.0f);
    }];
}

#pragma mark - get

- (UILabel *)detailL {
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.textColor = DetailTextColor;
        _detailL.font = SPICAL_DETAIL_FONT(14.0f);
        _detailL.textAlignment = NSTextAlignmentLeft;
        _detailL.numberOfLines = 0;
        NSString *str = @"The initial excitement over ICOs, with their ability to garner multi-million dollar investments and virtually no taxation or regulation, seems to have faded as rapidly as it has started. And while much of its popularity was killed by government regulation, and sometimes even outright bans, the meager success rate, and the scamming issues also attributed to the negative sentiment towards ICOsThe initial excitement over ICOs, with their ability to garner multi-million dollar investments and virtually no taxation or regulation, seems to have faded as rapidly as it has started. And while much of its popularity was killed by government regulation, and sometimes even outright bans, the meager success rate, and the scamming issues also attributed to the negative sentiment towards ICOsThe initial excitement over ICOs, with their ability to garner multi-million dollar investments and virtually no taxation or regulation, seems to have faded as rapidly as it has started. And while much of its popularity was killed by government regulation, and sometimes even outright bans, the meager success rate, and the scamming issues also attributed to the negative sentiment towards ICOsThe initial excitement over ICOs, with their ability to garner multi-million dollar investments and virtually no taxation or regulation, seems to have faded as rapidly as it has started. And while much of its popularity was killed by government regulation, and sometimes even outright bans, the meager success rate, and the scamming issues also attributed to the negative sentiment towards ICOs";
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr adjustmentLineSpaceWithSpace:5.0f];
        _detailL.attributedText = attStr;
    }
    return _detailL;
}

@end
