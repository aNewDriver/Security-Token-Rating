//
//  NSAttributedString+WKAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/18.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "NSAttributedString+WKAdd.h"

@implementation NSMutableAttributedString (WKAdd)

- (void)adjustmentLineSpaceWithSpace:(CGFloat)space {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space; // 调整行间距
    NSRange range = NSMakeRange(0, [self length]);
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

@end
