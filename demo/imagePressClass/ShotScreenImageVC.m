//
//  ShotScreenImageVC.m
//  demo
//
//  Created by 吴斌清 on 2018/1/4.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "ShotScreenImageVC.h"

@interface ShotScreenImageVC ()

@end

@implementation ShotScreenImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.contentSize = CGSizeMake(700, 700);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"截图" style:UIBarButtonItemStylePlain target:self action:@selector(shotScreen:)];
    
    
}

- (void)shotScreen:(id)sender{
    
    UIImage *image = [UIImage imageNamed:@"4.jpg"];
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //先clipContext  规则的
    /*
    CGRect rect = CGRectMake(0, 0, 200, 200);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
     */
    
    //非规则的
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPoint lines[] = {
        CGPointMake(0, 0),
        CGPointMake(150, 70),
        CGPointMake(200, 200),
        CGPointMake(50, 120),
        CGPointMake(0, 0)
    };
    CGPathAddLines(pathRef, NULL, lines, 5);
    CGContextAddPath(context, pathRef);
    CGContextClip(context);
    
    
    [image drawInRect:CGRectMake(0, 0, 200, 200)];
    
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndPDFContext();
    
    _showImageView.image = clipImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
