//
//  WBQTableView.h
//  demo
//
//  Created by 吴斌清 on 2018/1/2.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBQTableViewCell.h"
@class WBQTableView;

@protocol WBQTableViewDelegate
@required
-(NSInteger)tableView:(WBQTableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(WBQTableViewCell *)tableView:(WBQTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)tableView:(WBQTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface WBQTableView : UIScrollView

@property(nonatomic,weak)id<WBQTableViewDelegate>WBQDelegate;

-(void)reloadData;

-(WBQTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
