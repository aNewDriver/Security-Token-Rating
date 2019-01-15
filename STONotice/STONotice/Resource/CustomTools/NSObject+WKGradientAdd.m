//
//  NSObject+WKGradientAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/15.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "NSObject+WKGradientAdd.h"

@implementation NSObject (WKGradientAdd)

- (CAGradientLayer *)drawAGradientLayerWithColors:(NSArray <UIColor *>*)colors frame:(CGRect)frame {
    if (frame.size.width ==0 || frame.size.height == 0) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *array = @[].mutableCopy;
    for (NSUInteger i = 0; i < colors.count; i++) {
        UIColor *color = colors[i];
        [array addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = array;
    gradientLayer.locations = @[@0.3, @0.5, @0.7, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}

- (UIView *)gradientViewWithColors:(NSArray <UIColor *>*)colors frame:(CGRect)frame {
    CAGradientLayer *layer = [self drawAGradientLayerWithColors:colors frame:frame];
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    [backView.layer addSublayer:layer];
    return backView;
}

- (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors frame:(CGRect)frame {
    UIView *view = [self gradientViewWithColors:colors frame:frame];
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

@end
