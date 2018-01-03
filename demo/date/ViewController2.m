//
//  ViewController2.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "ViewController2.h"
#import "DateCell.h"
#import "DateModel.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_dayAry;
}

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"2018年1月";
    _dayAry = [NSMutableArray new];
    
    NSInteger firstWeekDay = [DateModel weekDayMonthOfFirstDayFromDateStr:@"2018-01-08"];
    
//    NSInteger firstWeekDay = [DateModel weekDayMonthOfFirstDayFromDate:[NSDate date]];
    //补充前面空白
    for (int i=0; i<firstWeekDay; i++) {
        [_dayAry addObject:@""];
    }
    
    NSInteger dayCount = [DateModel totalDaysInMonthFromStr:@"2018-01-08"];
//    NSInteger dayCount = [DateModel totalDaysInMonthFromDate:[NSDate date]];
    for (int i=0; i<dayCount; i++) {
        [_dayAry addObject:@(i+1)];
    }
    
    //补后面的空白
    int leftDay = 0;
    if (_dayAry.count%7) {
        leftDay = 7 - _dayAry.count%7;
    }
    for (int i=0; i<leftDay; i++) {
        [_dayAry addObject:@""];
    }
    
    /*
     代码初始化的时候，一定要用initWithFrame : UICollectionViewLayout
     UICollectionViewLayout 不能直接初始化这个布局对象，必须实现它的子类
     更复杂的布局需要自己写UIcollectionViewLayout的子类(如瀑布流)
     */
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DateCell" bundle:nil]  forCellWithReuseIdentifier:@"DateCell"];
//    [_collectionView registerClass:nil forCellWithReuseIdentifier:@""];
    [_collectionView registerNib:[UINib nibWithNibName:@"DateHeadView" bundle:nil]   forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DateHeadView"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(ScreenWidth/7, ScreenWidth/7);
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth/7, ScreenWidth/7);
    [_collectionView setCollectionViewLayout:flowLayout];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dayAry.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCell" forIndexPath:indexPath];
    cell.textLabel.text = [_dayAry[indexPath.row] description];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DateHeadView" forIndexPath:indexPath];
        return headView;
    }
    return nil;
}



@end
