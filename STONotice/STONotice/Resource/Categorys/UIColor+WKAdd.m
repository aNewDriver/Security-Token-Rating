//
//  UIColor+WKAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/24.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "UIColor+WKAdd.h"

@implementation UIColor (WKAdd)

- (UIImage *)createImageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
