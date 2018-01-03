//
//  CollectionViewController.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomCollectionViewLayout.h"
#import "DateCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface CollectionViewController (){
    NSMutableArray *_colorAry;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _colorAry = [NSMutableArray array];
    [_colorAry addObject:[UIColor whiteColor]];
    [_colorAry addObject:[UIColor blueColor]];
    [_colorAry addObject:[UIColor blackColor]];
    [_colorAry addObject:[UIColor orangeColor]];
    [_colorAry addObject:[UIColor redColor]];
    [_colorAry addObject:[UIColor greenColor]];
    [_colorAry addObject:[UIColor purpleColor]];
    [_colorAry addObject:[UIColor cyanColor]];
    
    self.title = @"customCollectionView";
    [_collectionView registerNib:[UINib nibWithNibName:@"DateCell" bundle:nil]  forCellWithReuseIdentifier:@"DateCell"];
    [_collectionView setCollectionViewLayout:[CustomCollectionViewLayout new]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 80;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCell" forIndexPath:indexPath];
    cell.textLabel.text = [@(indexPath.row) description];
    cell.backgroundColor = _colorAry[indexPath.row%_colorAry.count];
    return cell;
}


@end
