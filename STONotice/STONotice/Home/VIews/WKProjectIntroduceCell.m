//
//  WKProjectIntroduceCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKProjectIntroduceCell.h"
#import "WKBaseWebViewController.h"

@interface WKProjectIntroduceCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *linkBtn;
@property (nonatomic, assign) ProjectIntroduceCellType projectIntroduceCellType;
@property (nonatomic, copy) NSString *URLString;

@end

@implementation WKProjectIntroduceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ProjectIntroduceCellType:(ProjectIntroduceCellType)projectIntroduceCellType {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.projectIntroduceCellType = projectIntroduceCellType;
        [self configureUIAndFrame];
    }
    return self;
}

- (void)updateCellWithModel:(WKPostInfoModel *)model index:(NSUInteger)index{
    if (self.projectIntroduceCellType == ProjectIntroduceCellType_haveName) { //!< 有名字
        if (model.detailModel.teamMember) {
            WKProjectTeamMember *tModel = model.detailModel.teamMember[index];
            self.nameLabel.text = tModel.name;
            self.detailLabel.attributedText = [tModel.desc attStrEncodeWithFont:SPICAL_DETAIL_FONT(14.0f) textColor:DetailTextColor textAlignment:NSTextAlignmentLeft];
            self.URLString = tModel.linkUrl;
            if ([self.URLString isEmpty]) {
                self.linkBtn.hidden = YES;
            } else {
                self.linkBtn.hidden = NO;
            }
        }
    } else {
        self.detailLabel.attributedText = [model.detailModel.projectSummary attStrEncodeWithFont:SPICAL_DETAIL_FONT(14.0f) textColor:DetailTextColor textAlignment:NSTextAlignmentLeft];
    }
}


#pragma mark - configure

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.detailLabel];

    if (self.projectIntroduceCellType == ProjectIntroduceCellType_haveName) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.linkBtn];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15.0f);
            make.height.equalTo(@20.0f);
            make.width.equalTo(self.nameLabel.mas_width);
        }];
        [self.linkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.left.equalTo(self.nameLabel.mas_right).offset(10.0f);
            make.height.width.equalTo(@20.0f);
        }];
        
    }
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15.0f);
        make.right.equalTo(self.contentView.mas_right).offset(-15.0f);
        if (self.projectIntroduceCellType == ProjectIntroduceCellType_haveName) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10.0f);
        } else {
            make.top.equalTo(self.contentView).offset(15.0f);
        }
        make.height.equalTo(self.detailLabel.mas_height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15.0f);
    }];
    
    

}

- (void)btnClick{
    
    
    WKBaseViewController *webVC = [[WKBaseWebViewController alloc] initWithUrlString:self.URLString];
    
    [self.viewController.navigationController pushViewController:webVC animated:YES];
        
}


#pragma mark - get

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = TitleTextColor;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = SPICAL_FONT(14.0f);
        _nameLabel.text = @"ke.wang";
    }
    return _nameLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = DetailTextColor;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = SPICAL_DETAIL_FONT(14.0f);
        _detailLabel.text = @"Lucas is the former CEO of Bank Morgan Stanley AG, the private bank of Morgan Stanley with branches in Switzerland and Asia. Prior to that he was the Deputy Head of Morgan Stanley Wealth Management Asia and the COO of International Wealth Management.";
    }
    return _detailLabel;
}

- (UIButton *)linkBtn {
    if (!_linkBtn) {
        _linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _linkBtn.backgroundColor = [UIColor clearColor];
        _linkBtn.layer.cornerRadius = 10;
        [_linkBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [_linkBtn setImage:[UIImage imageNamed:@"linkIcon"] forState:UIControlStateNormal];
    }
    return _linkBtn;
}


@end
