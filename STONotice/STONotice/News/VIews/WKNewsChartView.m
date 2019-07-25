//
//  WKNewsChartView.m
//  STONotice
//
//  Created by Ke Wang on 2019/3/11.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKNewsChartView.h"
#import "WKRatingView.h"

NSUInteger count = 0;

@interface WKNewsChartView ()

@property (nonatomic, strong) CAShapeLayer *chartLayer;
@property (nonatomic, assign) CGFloat total;
@property (nonatomic, strong) NSMutableArray *allLayers;

@property (nonatomic, strong) WKRatingView *ratingView;
@property (nonatomic, strong) NSMutableArray *allProView;

@end

@implementation WKNewsChartView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.ratingView = [[WKRatingView alloc] initWithFrame:CGRectMake(200, 50, 80, 80)];
        [self addSubview:self.ratingView];
    }
    return self;
}

- (void)drawChartLayerWithDataItems:(nonnull NSArray *)dataItems
                             colors:(nonnull NSArray <UIColor *> *)colors
                             titles:(NSArray <NSString *> *)titles
                            atFrame:(CGRect)frame {
    if (dataItems.count != colors.count) {
        NSAssert(1, @"dataItems's count is not eqaul colors's count");
        return;
    }
    self.allLayers = @[].mutableCopy;
    self.allProView = @[].mutableCopy;
    
//    self.backgroundColor = BACKGROUND_COLOR;
    
    CGFloat centerX = frame.size.width * 0.5f;
    CGFloat centerY = frame.size.height * 0.5f;
    CGPoint centerPoint = CGPointMake(centerX, centerY);
    
    //!< 计算圆角坐标
    CGFloat basicRadius = centerX > centerY ? centerY : centerX;
    
    self.total = 0.00f;
    
    for (NSUInteger i = 0; i < dataItems.count; i++) {
        self.total += [dataItems[i] floatValue];
    }
    
    CGFloat littleRedius = basicRadius * 0.5 - 0.0;
    
    UIBezierPath *littlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:littleRedius startAngle:- M_PI endAngle:M_PI clockwise:YES];
    
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;
    CGFloat proHeight = 8.0f;
    CGFloat proWidth = 100.0f;
    
    for (int i = 0; i < dataItems.count; i++) {
        end = [dataItems[i] floatValue] / _total + start;
        CAShapeLayer *pie = [CAShapeLayer layer];
        [self.layer addSublayer:pie];

        pie.fillColor   = [UIColor clearColor].CGColor;
        pie.strokeColor = colors[i].CGColor;
        pie.strokeStart = start;
        pie.strokeEnd   = end;
        pie.lineWidth   = littleRedius * 0.5f;
        pie.zPosition   = 2;
        pie.path        = littlePath.CGPath;
        pie.frame       = frame;
        [self.allLayers addObject:pie];
        
        UIProgressView *proV = [self createProgressViewWithTincolor:colors[i] bgColor:[UIColor clearColor]];
        proV.frame = CGRectMake(200, 100 + (proHeight + 10) *i, proWidth, proHeight);
        [self addSubview:proV];
        
        [self.allProView addObject:proV];

        start = end;
    }

    [self allMakeAnimation];
}

- (UIProgressView *)createProgressViewWithTincolor:(UIColor *)tincolor bgColor:(UIColor *)bgColor {
    UIProgressView *proV = [[UIProgressView alloc] init];
    proV.progressTintColor = tincolor;
    proV.backgroundColor = bgColor;
    proV.progressViewStyle = UIProgressViewStyleBar;
    proV.layer.borderWidth = 0.5f;
    proV.layer.borderColor =[UIColor redColor].CGColor;
    return proV;
}


- (void)allMakeAnimation {
    for (int i = 0; i < self.allLayers.count; i++) {
        CAShapeLayer *layer = self.allLayers[i];
        [self makeAnimationWithLayer:layer];
    }
    
    for (int i = 0; i < self.allProView.count; i++) {
        UIProgressView *prov = self.allProView[i];
        [prov setProgress:0.5 animated:YES];
    }
}

- (void)makeAnimationWithLayer:(CAShapeLayer *)layer {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = 1.5f;
    animation.fromValue = @0.0f;
    animation.toValue   = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [layer addAnimation:animation forKey:@"circleAnimation"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self allMakeAnimation];
    
    self.ratingView.value = count == 0 ? 1 : 0.5;
    
    count = count + 1 > 1 ? 0 : 1;
    
    
}

@end

