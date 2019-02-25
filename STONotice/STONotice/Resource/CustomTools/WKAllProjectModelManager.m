//
//  WKAllProjectModelManager.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/22.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKAllProjectModelManager.h"

static WKAllProjectModelManager *sharedManager = nil;

@interface WKAllProjectModelManager ()

@end

@implementation WKAllProjectModelManager

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WKAllProjectModelManager alloc]init];
    });
    return sharedManager;
}

- (void)updateModel:(WKPostInfoModel *)model {
    
    [self.allProjectModels enumerateObjectsUsingBlock:^(WKPostInfoModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.postId isEqualToString:model.postId]) {
            obj = model;
        }
    }];
}


@end
