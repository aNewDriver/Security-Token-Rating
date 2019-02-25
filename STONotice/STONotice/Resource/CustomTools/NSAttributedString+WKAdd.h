//
//  NSAttributedString+WKAdd.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/18.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (WKAdd)


/**
 调整行间距

 @param space 间距
 */
- (void)adjustmentLineSpaceWithSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
