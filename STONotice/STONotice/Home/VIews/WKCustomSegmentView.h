//
//  WKCustomSegmentView.h
//  STONotice
//
//  Created by Ke Wang on 2019/1/16.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKCustomSegmentView : UIView

- (instancetype)initWithSegmentTitles:(NSArray <NSString *>*)segmentTitles;

@property (nonatomic, copy) void(^segmentCilck)(NSUInteger index);


@end

NS_ASSUME_NONNULL_END
