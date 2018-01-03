//
//  navigationSystemPopVC.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "navigationSystemPopVC.h"
#import "navigationAnimation.h"
#import "ViewController1.h"

@interface navigationSystemPopVC ()<UINavigationControllerDelegate>

@end

@implementation navigationSystemPopVC

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    self.navigationController.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"替换导航栏back返回动画";
    //设置了yes也没有用
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    /*系统导航栏手势
    <UIScreenEdgePanGestureRecognizer: 0x7ff1c2c04610; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7ff1c2d14b50>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7ff1c2c02550>)>>
     */
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {//判断pop才使用动画
        return [[navigationAnimation alloc]init];
    }
    return nil;
}
- (IBAction)pushNextCtrl:(id)sender {
    [self.navigationController pushViewController:[ViewController1 new] animated:YES];
}


@end
