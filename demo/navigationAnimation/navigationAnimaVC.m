//
//  navigationAnimaVC.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "navigationAnimaVC.h"

@interface navigationAnimaVC ()

@end

@implementation navigationAnimaVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
}


-(void)panGesture:(UIPanGestureRecognizer *)gesture{
    //获取当前的view(fromView)  和要pop的view(toView)、
    
    UIView *containView = [self.view superview];
    
    UIView *fromView = self.view;
    UIView *toView = nil;
    NSArray *viewCtrlAry = self.navigationController.viewControllers;
    if (viewCtrlAry.count >= 2) {
        UIViewController *toViewCtrl = viewCtrlAry[viewCtrlAry.count - 2];
        toView = toViewCtrl.view;
    }
    
    [containView insertSubview:toView belowSubview:fromView];
    
    //滑动的距离
    CGPoint movePoint = [gesture translationInView:self.view];
    //滑动后清空point
    [gesture setTranslation:CGPointZero inView:self.view];
    float moveWidth = movePoint.x;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //开始
        toView.frame = CGRectMake(-toView.frame.size.width, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        //移动
        toView.frame = CGRectMake(toView.frame.origin.x + moveWidth, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        fromView.frame = CGRectMake(fromView.frame.origin.x + moveWidth, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
    }else{
        //结束
        if (fromView.frame.origin.x > [UIScreen mainScreen].bounds.size.width/2) {
            //pop
            [UIView animateWithDuration:0.4 animations:^{
                toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
                fromView.frame = CGRectMake(fromView.frame.size.width, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
                
            } completion:^(BOOL finished) {
                NSMutableArray *viewAry = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                [viewAry removeLastObject];
                self.navigationController.viewControllers = viewAry;
            }];
            
        }else{
            //还原
            [UIView animateWithDuration:0.4 animations:^{
                fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
                toView.frame = CGRectMake(-toView.frame.size.width, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
