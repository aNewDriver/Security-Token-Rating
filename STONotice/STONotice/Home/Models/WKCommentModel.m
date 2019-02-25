
//
//  WKCommentModel.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/21.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKCommentModel.h"

@implementation WKCommentModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"commontId":@"id"};
}

@end

@implementation WKCommentAvatarURLModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"big":@"96",
             @"middle":@"64",
             @"little":@"26",
             };
}

@end
