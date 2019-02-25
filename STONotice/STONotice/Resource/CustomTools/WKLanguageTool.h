//
//  WKLanguageTool.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

//!< 国际化语言设置

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKLanguageTool : NSObject

+(id)sharedInstance;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
-(NSString *)getStringForKey:(NSString *)key withTable:(nullable NSString *)table;

/**
 *  改变当前语言
 */
-(void)changeNowLanguage;

/**
 *  设置新的语言
 *
 *  @param language 新语言
 */
-(void)setNewLanguage:(NSString*)language;


/**
 j获取当前的语言

 @return 当前的语言
 */
- (NSString *)currentLanague;


@end

NS_ASSUME_NONNULL_END
