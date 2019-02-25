//
//  NSString+WKAdd.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "NSString+WKAdd.h"

@implementation NSString (WKAdd)

- (BOOL)isEmpty {
    if (self == nil) {
        return YES;
    }
    
    if ([self isEqualToString:@"<nil>"] || [self isEqualToString:@"null"] || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"] || [self isKindOfClass:[NSNull class]] || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (BOOL)emailAddressJude {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)justContainCHN {
    NSString *regexStr = @"[\u4e00-\u9fa5]+";
    NSPredicate *predStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    if (![predStr evaluateWithObject:self]) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)justContainNumber {
    NSString *regexNumber = @"[0-9]*";
    NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexNumber];
    if (![predNumber evaluateWithObject:self]) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)justContainChars {
    NSString *regexLetter = @"[a-zA-Z]*";
    NSPredicate *predLetter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexLetter];
    if (![predLetter evaluateWithObject:self]) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)containCharsAndNumber {
    NSString *regexLM = @"[a-zA-Z0-9]*";
    NSPredicate *predLM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexLM];
    if (![predLM evaluateWithObject:self]) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)containBigChars {
    NSString *regexLM = @"[A-Z]*";
    NSPredicate *predLM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexLM];
    if (![predLM evaluateWithObject:self]) {
        return NO;
    }else {
        return YES;
    }
}



- (NSString *)subStrAtCharsRangeWithStartChar:(NSString *)startChar endChar:(NSString *)endChar {
    
    if (![self containsString:startChar]) {
        return self;
    }
    if (![self containsString:endChar]) {
        return self;
    }
    NSRange startRange = [self rangeOfString:startChar];
    NSRange endRange = [self rangeOfString:endChar];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    if (range.length > self.length) {
        return self;
    }
    NSString *result = [self substringWithRange:range];
    return result;
}

- (NSString *)chageFenHao {
    if ([self containsString:@"&#8217;"]) {
        return [self stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
    }
    return self;
}

- (NSAttributedString *)attStrEncodeWithFont:(UIFont *)font
                                   textColor:(UIColor *)textColor
                               textAlignment:(NSTextAlignment)textAlignment{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                           NSCharacterEncodingDocumentAttribute : @(NSUTF8StringEncoding)
                           };
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:dic documentAttributes:nil error:nil];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
    
    [attStr addAttributes:@{NSFontAttributeName : font,
                            NSForegroundColorAttributeName : textColor,
                            }
                    range:NSMakeRange(0, attStr.length)];
    
    [attStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraphStyle
                    range:NSMakeRange(0, attStr.length)];
    
    return attStr.copy;
}


- (NSString *)unicode2ISO88591 {
    
    NSStringEncoding enc =      CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    
    return [NSString stringWithCString:[self UTF8String] encoding:enc];
    
}

- (NSString *)filterHTML
{
    NSScanner * scanner = [NSScanner scannerWithString:self];
    NSString * text = nil;
    NSString *result = @"";
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        result = [self stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return result;
}


- (BOOL)judgePassWordLegal {
     BOOL result ;
    BOOL containLittleC = NO;
    BOOL containBigC = NO;
    BOOL containNumber = NO;

    for (int i = 0; i<self.length; i++) {
        char commitChar = [self characterAtIndex:i];
        NSString *temp = [self substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
        }else if((commitChar>64)&&(commitChar<91)){
            containBigC = YES;
        }else if((commitChar>96)&&(commitChar<123)){
            containLittleC = YES;
        }else if((commitChar>47)&&(commitChar<58)){
            containNumber = YES;
        }else{
        }
    }
    result = containBigC && containLittleC && containNumber;
    return result;
}


- (NSAttributedString *)getAttributedWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self attributes:attriDict];
    return attributedString;
}

@end
