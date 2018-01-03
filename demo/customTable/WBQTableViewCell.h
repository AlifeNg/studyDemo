//
//  WBQTableViewCell.h
//  demo
//
//  Created by 吴斌清 on 2018/1/2.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBQTableViewCell : UIView

@property(nonatomic,strong)NSString *identifier;


@property(nonatomic,strong)UILabel *textLable;


-(instancetype)initWithIdentifier:(NSString *)identifier;
@end
