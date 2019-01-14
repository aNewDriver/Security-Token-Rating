//
//  WKProjectDiscussCell.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/14.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//

#import "WKProjectDiscussCell.h"
#import "WKDisCollectionViewCell.h"

@interface WKProjectDiscussCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mainCV;


@end

@implementation WKProjectDiscussCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUIAndFrame];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configureUIAndFrame {
    [self.contentView addSubview:self.mainCV];
    
    [self.mainCV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.top.equalTo(self.contentView);
    }];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WKDisCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WKDisCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - get

- (UICollectionView *)mainCV {
    if (!_mainCV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(160, 165);
        layout.minimumInteritemSpacing = 10.0f;
        
        _mainCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCV.delegate = self;
        _mainCV.dataSource = self;
        _mainCV.backgroundColor = BACKGROUND_COLOR;
//        _mainCV.pagingEnabled = YES;
        [_mainCV registerClass:[WKDisCollectionViewCell class] forCellWithReuseIdentifier:@"WKDisCollectionViewCell"];
    }
    return _mainCV;
}

@end
