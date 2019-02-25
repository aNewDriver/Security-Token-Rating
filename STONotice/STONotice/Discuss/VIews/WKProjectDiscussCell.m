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

- (void)setProjectModelArray:(NSArray<WKPostInfoModel *> *)projectModelArray {
    _projectModelArray = projectModelArray;
    
    [self.mainCV reloadData];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projectModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WKDisCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WKDisCollectionViewCell" forIndexPath:indexPath];
    
    WKPostInfoModel *model = self.projectModelArray[indexPath.row];
    
    [cell updateCellWithModel:model];
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelecetedAtIndexPath) {
        self.didSelecetedAtIndexPath(indexPath);
    }
    
}


#pragma mark - get

- (UICollectionView *)mainCV {
    if (!_mainCV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(190, 165);
//        layout.minimumInteritemSpacing = -20.0f;
        layout.minimumLineSpacing = -20.0f;
        
        _mainCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCV.delegate = self;
        _mainCV.dataSource = self;
        _mainCV.backgroundColor = BACKGROUND_COLOR;
//        _mainCV.pagingEnabled = YES;
        [_mainCV registerClass:[WKDisCollectionViewCell class] forCellWithReuseIdentifier:@"WKDisCollectionViewCell"];
        _mainCV.showsHorizontalScrollIndicator = NO;
    }
    return _mainCV;
}

@end
