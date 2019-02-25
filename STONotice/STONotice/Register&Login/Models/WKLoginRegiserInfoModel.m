//
//  WKLoginRegiserInfoModel.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/23.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import "WKLoginRegiserInfoModel.h"

@interface WKLoginRegiserInfoModel ()<NSCoding>

@end

@implementation WKLoginRegiserInfoModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.user_display_name forKey:@"user_display_name"];
    [aCoder encodeObject:self.user_email forKey:@"user_email"];
    [aCoder encodeObject:self.user_nicename forKey:@"user_nicename"];

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.user_display_name = [aDecoder decodeObjectForKey:@"user_display_name"];
        self.user_email = [aDecoder decodeObjectForKey:@"user_email"];
        self.user_nicename = [aDecoder decodeObjectForKey:@"user_nicename"];
    }
    return self;
}

@end
