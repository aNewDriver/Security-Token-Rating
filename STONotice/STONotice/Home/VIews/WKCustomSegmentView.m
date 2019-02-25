//
//  WKCustomSegmentView.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#define ButtonTag 10000

#import "WKCustomSegmentView.h"

@interface WKCustomSegmentView ()

@property (nonatomic, copy) NSArray <NSString *> *segmentTitles;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *line;

@end

@implementation WKCustomSegmentView

- (instancetype)initWithSegmentTitles:(NSArray <NSString *>*)segmentTitles
{
    self = [super init];
    if (self) {
        self.segmentTitles = segmentTitles;
        [self confogureSegments];
    }
    return self;
}

#pragma mark - method

- (void)btnClick:(UIButton *)sender {
    NSUInteger tag = sender.tag;
    if (tag != self.selectedBtn.tag) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
        [self makeAnamationWithTag:tag - ButtonTag];
    }
    
    if (self.segmentCilck) {
        self.segmentCilck(tag - ButtonTag);
    }
}

- (void)makeAnamationWithTag:(NSUInteger)tag {
    CGFloat width = SCREEN_WIDTH / self.segmentTitles.count;
    [self.indicator mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(width * tag);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)confogureSegments {
    if (self.segmentTitles.count < 2) {
        return;
    }
    [self addSubview:self.indicator];
    [self addSubview:self.line];
    
    CGFloat width = SCREEN_WIDTH / self.segmentTitles.count;
    for (NSUInteger i = 0; i < self.segmentTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSAttributedString *normalAttstr = [[NSAttributedString alloc] initWithString:self.segmentTitles[i] attributes:@{NSForegroundColorAttributeName : RGBCOLOR(170, 170, 170), NSFontAttributeName : SPICAL_FONT(15.0f)}];
        [button setAttributedTitle:normalAttstr forState:UIControlStateNormal];
        
        NSAttributedString *selectedAttstr = [[NSAttributedString alloc] initWithString:self.segmentTitles[i] attributes:@{NSForegroundColorAttributeName : LoginRegisterBlue, NSFontAttributeName : SPICAL_DETAIL_FONT(15.0f)}];
        [button setAttributedTitle:selectedAttstr forState:UIControlStateSelected];
        button.tag = ButtonTag + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(width * i);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-2.0f);
            make.width.equalTo(@(width));
        }];
        
        if (i == 0) {
            self.selectedBtn = button;
            button.selected = YES;
        }
    }
    
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(2);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
}

#pragma mark - get

- (UIView *)indicator {
    if (!_indicator) {
        _indicator = [[UIView alloc] init];
        _indicator.backgroundColor = LoginRegisterBlue;
    }
    return _indicator;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = BACKGROUND_COLOR;
    }
    return _line;
}




@end
