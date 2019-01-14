//
//  UITextView+WKPlaceHolder.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (WKPlaceHolder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;


@end

NS_ASSUME_NONNULL_END
