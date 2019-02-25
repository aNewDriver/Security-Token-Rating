//
//  WKAllProjectModelManager.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/22.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKAllProjectModelManager : NSObject

@property (nonatomic, copy) NSArray *allProjectModels;

+ (id)sharedManager;

- (void)updateModel:(WKPostInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
