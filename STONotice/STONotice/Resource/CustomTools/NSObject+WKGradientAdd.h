//
//  NSObject+WKGradientAdd.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/15.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (WKGradientAdd)

/**
 获得一个渐变色layer
 
 @param colors colors
 @param frame frame
 @return layer
 */
- (CAGradientLayer *)drawAGradientLayerWithColors:(NSArray <UIColor *>*)colors frame:(CGRect)frame;

/**
 获得一个渐变色view
 
 @param colors colors
 @param frame frame
 @return layer
 */
- (UIView *)gradientViewWithColors:(NSArray <UIColor *>*)colors frame:(CGRect)frame;


/**
 获得一个渐变色image
 
 @param colors colors
 @param frame frame
 @return layer
 */
- (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors frame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
