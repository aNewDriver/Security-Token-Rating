//
//  NSString+WKAdd.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/9.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WKAdd)

- (BOOL)isEmpty;


/**
 校验邮箱格式

 @return BOOL
 */
- (BOOL)emailAddressJude;


/**
 是否只包含中文

 @return BOOL
 */
- (BOOL)justContainCHN;


/**
 是否只包含数字

 @return BOOL
 */
- (BOOL)justContainNumber;


/**
 是否只包含字母

 @return BOOL
 */
- (BOOL)justContainChars;


/**
 是否包含数字和字母

 @return BOOL
 */
- (BOOL)containCharsAndNumber;


/**
 q获取两个字符之间的字符串

 @param startChar 起始字符
 @param endChar 结束字符
 @return 之间的字符串
 */
- (NSString *)subStrAtCharsRangeWithStartChar:(NSString *)startChar endChar:(NSString *)endChar;


/**
 将乱码转换成分号

 @return 转换完成的字符串
 */
- (NSString *)chageFenHao;


/**
 大写字母
 @return 包不包含
 */
- (BOOL)containBigChars;


/**
 encode

 @return 结果
 */
- (NSAttributedString *)attStrEncodeWithFont:(UIFont *)font
                                   textColor:(UIColor *)textColor
                               textAlignment:(NSTextAlignment)textAlignment;
- (NSString *)unicode2ISO88591;


/**
 密码正则校验

 @return 是否通过
 */
- (BOOL)judgePassWordLegal;


/**
 设置字体的字间距和行间距

 @param lineSpace 行间距
 @param kern 字间距
 @param font 字体
 @return attstr
 */
- (NSAttributedString *)getAttributedWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
