//
//  CoreTextVC.m
//  demo
//
//  Created by 吴斌清 on 2018/1/4.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "CoreTextVC.h"
#import "TextLabel.h"


@interface CoreTextVC (){
    TextLabel *_textLabel;
}

@end

@implementation CoreTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textLabel = [[TextLabel alloc]initWithFrame:CGRectMake(0, 100, 200, 300)];
    _textLabel.userInteractionEnabled = YES;
    _textLabel.text = @"asdsabjsajku231893789127398127dsadaESAclsaEWQECXZ127dsadaESAclsaEWQECXZ127dsadaESAclsaEWQECXZ127dsadaESAclsaEWQECXZ";
    [self.view addSubview:_textLabel];
    
    
}

@end
