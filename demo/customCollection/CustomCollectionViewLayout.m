//
//  CustomCollectionViewLayout.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout{
    NSMutableArray *_layoutAry;
    NSInteger _collectionViewRowCount;
    NSMutableArray *_originYAry;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        _layoutAry = [NSMutableArray new];
        _originYAry = [NSMutableArray new];
        _collectionViewRowCount = 3;
    }
    return self;
}

-(void)prepareLayout{
    //准备数据 对每一个cell的布局进行初始化
    [_layoutAry removeAllObjects];
    [_originYAry removeAllObjects];
    for (int i=0; i<_collectionViewRowCount; i++) {
        [_originYAry addObject:@(0)];
    }

    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i< cellCount; i++) {
        //初始化每一个cell的布局属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_layoutAry addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize{
    
    float maxHeight = [_originYAry[0] floatValue];
    for (int i=1; i<_collectionViewRowCount; i++) {
        if (maxHeight < [_originYAry[i] floatValue]) {
            maxHeight = [_originYAry[i] floatValue];
        }
    }
    CGSize contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, maxHeight);
    return contentSize;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    float cellSizeWidth = [UIScreen mainScreen].bounds.size.width / _collectionViewRowCount;
    float cellSizeHeight = 50 + arc4random_uniform(100);//通过索引算出cell相应的高度
    float cellX = cellSizeWidth*(indexPath.row%_collectionViewRowCount);
    float cellY = [_originYAry[indexPath.row%_collectionViewRowCount] floatValue];
    
    _originYAry[indexPath.row%_collectionViewRowCount] = @(cellY + cellSizeHeight);
    
    attributes.frame = CGRectMake(cellX, cellY, cellSizeWidth, cellSizeHeight);
    
    return attributes;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // return an array layout attributes instances for all the views in the given rect
    return _layoutAry;
}

@end
