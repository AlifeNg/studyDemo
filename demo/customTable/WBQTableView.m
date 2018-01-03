//
//  WBQTableView.m
//  demo
//
//  Created by 吴斌清 on 2018/1/2.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "WBQTableView.h"
#import "WBQCellModel.h"
#import "WBQTableViewCell.h"

@implementation WBQTableView{
    NSMutableArray *_cellInfoAry;
    
    //key是 indexpath.row value是cell
    NSMutableDictionary *_visibleCellDict;
    
    NSMutableArray *_reusePoolCellAry;
}

/*
 1 数据准备
 1.1cell的数量
 1.2cell的位置和高度
 
 
 2 UI
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellInfoAry = [NSMutableArray new];
        _visibleCellDict = [NSMutableDictionary new];
        _reusePoolCellAry = [NSMutableArray new];
    }
    return self;
}

-(void)dataHandle{
    //    1.1cell的数量
    //不做section的处理 section=0
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSInteger cellAllCount = [self.WBQDelegate tableView:self numberOfRowsInSection:indexPath];
    
    //    1.2cell的位置和高度
    
    CGFloat addupHeight = 0;
    
    for (int i = 0; i<cellAllCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        CGFloat cellHeight = [self.WBQDelegate tableView:self heightForRowAtIndexPath:indexPath];
     
        WBQCellModel *wbqCellModel = [WBQCellModel new];
        wbqCellModel.y = addupHeight;
        wbqCellModel.heigth = cellHeight;
        
        addupHeight += cellHeight;
        
        [_cellInfoAry addObject:wbqCellModel];
    }
    
    [self setContentSize:CGSizeMake(self.frame.size.width, addupHeight)];
    
}

//UI布局
-(void)layoutSubviews{
    //2.1计算可视范围
    CGFloat startY = (self.contentOffset.y < 0)?0:self.contentOffset.y;
    CGFloat endY   = ((self.contentOffset.y + self.frame.size.height) > self.contentSize.height) ? self.contentSize.height:(self.contentOffset.y + self.frame.size.height) ;
    //2.2添加相应的cell
    NSInteger startIndex = -1;
    NSInteger endIndex = 0;
    NSInteger index = 0;
    
    
    WBQCellModel *startCellM = [WBQCellModel new];
    startCellM.y = startY;
    startIndex = [self binarySearch:_cellInfoAry target:startCellM];
    
    WBQCellModel *endCellM = [WBQCellModel new];
    endCellM.y = endY;
    endIndex = [self binarySearch:_cellInfoAry target:endCellM];
    
    //2.2.1计算startIndex
    /*
    for (; index < _cellInfoAry.count; index++) {
        WBQCellModel *cellModel =  _cellInfoAry[index];
        if (cellModel.y <= startY && cellModel.y + cellModel.heigth > startY) {
            startIndex = index;
            break;
        }
    }
    
    //2.2.2计算endIndex
    for (; index < _cellInfoAry.count; index++) {
        WBQCellModel *cellModel =  _cellInfoAry[index];
        if (cellModel.y < endY && cellModel.y + cellModel.heigth >= endY) {
            endIndex = index;
            break;
        }
    }
    */
    
     
    //2.2.3获取相应的cell  1.已经在界面上的cell  2.没有在界面上的cell
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        //如果对应的index的row已经在界面上了  就不需要刷新
        WBQTableViewCell *cell = _visibleCellDict[@(indexPath.row)];
//        cell =  [self.WBQDelegate tableView:self cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell =  [self.WBQDelegate tableView:self cellForRowAtIndexPath:indexPath];
            [self addSubview:cell];
        }
        //section = 0
        [_visibleCellDict setObject:cell forKey:@(indexPath.row)];
        //_visibleCellDict[@(indexPath.row)] = cell;
        [_reusePoolCellAry removeObject:cell];//这个cell可能是从重用池里拿的
        
        WBQCellModel *cellModel = _cellInfoAry[i];
        cell.frame = CGRectMake(0, cellModel.y, self.frame.size.width, cellModel.heigth);
    }
    
    
    //2.3添加之后移除多余的cell（不在可视范围内的cell） 移到重用池内
    //2.3.1 _visibleCellDict这个里面的数据进行处理 (不在界面上的)
    
    NSArray *visibleCellkeyAry = [_visibleCellDict allKeys];
    
    for (NSInteger i=0; i<visibleCellkeyAry.count; i++) {
        NSInteger index = [visibleCellkeyAry[i] integerValue];
        
        if (index < startIndex || index > endIndex) {
            //移除
            [_reusePoolCellAry addObject:_visibleCellDict[visibleCellkeyAry[i]]];
            [_visibleCellDict removeObjectForKey:visibleCellkeyAry[i]];
//            WBQTableViewCell *cell = visibleCellkeyAry[i];
//            [cell removeFromSuperview];
        }
    }
    
}

//重用池中获取cell
-(WBQTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    /*判断是否已经在现有池里面，如果在，那么直接从现有池里返回来
     需要做一个indexPath的成员变量
     */
    for (int i = 0 ; i<_reusePoolCellAry.count; i++) {
        WBQTableViewCell *cell = _reusePoolCellAry[i];
        if ([cell.identifier isEqualToString:identifier]) {
            return cell;
        }
    }
    
    return nil;
}

-(void)reloadData{
    
    [self dataHandle];
    [self setNeedsLayout];
    
}


/*
 二分查找
 
 1024
 
 */


int binarySearch(int *a, int min, int max, int target){
    
    int mid;
    while (min < max) {
        mid = min + (max - min)/2;
        
        if (target == a[mid]) {
            return mid;
        }else if (target < a[mid]){//在左边
            max = mid;
        }else{//在右边
            min = mid;
        }
    }
    return -1;
}


-(NSInteger)binarySearch:(NSArray *)dataAry target:(WBQCellModel *)targetModel{
    NSInteger min = 0;
    NSInteger max = dataAry.count - 1;
    NSInteger mid;
    while (min < max) {
        mid = min + (max - min)/2;
        //条件判断
        WBQCellModel *midModel = dataAry[mid];
        if (midModel.y <= targetModel.y && midModel.y + midModel.heigth > targetModel.y) {
            return mid;
        }else if (targetModel.y < midModel.y){//在左边
            max = mid;
            if (max - min == 1) {
                return min;
            }
        }else{//在右边
            min = mid;
            if (max - min == 1) {
                return max;
            }
        }
    }
    return -1;
}

@end
