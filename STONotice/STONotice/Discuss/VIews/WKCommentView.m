//
//  WKCommentView.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKCommentView.h"

@interface WKCommentView ()

@property (nonatomic, strong) UILabel *operationL;

@end

@implementation WKCommentView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.operationL];
        [self configureUIAndFrame];
    }
    return self;
}

#pragma mark - method

- (void)configureUIAndFrame {
    self.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:self.operationL];
    
    [self.operationL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10.0f);
        make.top.equalTo(@5.0f);
        make.right.equalTo(self.mas_right).offset(-10.0f);
        make.height.equalTo(@(30));
    }];
}

- (void)tapClicked:(UITapGestureRecognizer *)tap {
    if (tap.view) {
        if (self.tapClicked) {
            self.tapClicked();
        }
    }
}


#pragma mark - get

- (UILabel *)operationL {
    if (!_operationL) {
        _operationL = [[UILabel alloc] init];
        _operationL.text = @"  发表评论...";
        _operationL.textAlignment = NSTextAlignmentLeft;
        _operationL.textColor = RGBCOLOR(151, 151, 151);
        _operationL.font = SYSTEM_NORMAL_FONT(14.0f);
        _operationL.layer.borderColor = [UIColor blackColor].CGColor;
        _operationL.layer.borderWidth = 1.0f;
        _operationL.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
        [_operationL addGestureRecognizer:tap];
    }
    return _operationL;
}

@end
