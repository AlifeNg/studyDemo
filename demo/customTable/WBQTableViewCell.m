//
//  WBQTableViewCell.m
//  demo
//
//  Created by 吴斌清 on 2018/1/2.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "WBQTableViewCell.h"

@implementation WBQTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLable = [UILabel new];
    }
    return self;
}

-(instancetype)initWithIdentifier:(NSString *)identifier{
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (![_textLable superview]) {
        [self addSubview:_textLable];
    }
    _textLable.frame = CGRectMake(15, 0, self.frame.size.width - 15, self.frame.size.height);
}

@end
