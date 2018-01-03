//
//  navigationAnimation.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "navigationAnimation.h"

@implementation navigationAnimation{
    id <UIViewControllerContextTransitioning>_transitionContext;
}

//时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

//过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext = transitionContext;
    //获取toView   fromView
    UIViewController *toViewCtrl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewCtrl = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *transferView = transitionContext.containerView;
    UIView *fromView = fromViewCtrl.view;

    [transferView insertSubview:toViewCtrl.view belowSubview:fromViewCtrl.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame =  CGRectMake(fromView.frame.size.width, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
    } completion:^(BOOL finished) {
        //completes上下文
        [transitionContext completeTransition:YES];
    }];
}

- (void)animationTwo:(UIView *)transferView{
    CATransition *caTrans = [CATransition animation];
    caTrans.type = @"cube";
    caTrans.subtype = @"fromLeft";
    caTrans.duration = [self transitionDuration:_transitionContext];
    caTrans.fillMode = kCAFillModeForwards;
    caTrans.delegate = self;
    caTrans.removedOnCompletion = NO;
    
    [transferView.layer addAnimation:caTrans forKey:nil];
    [transferView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}

//context结束
- (void)animationEnded:(BOOL) transitionCompleted{
    
}

//动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:YES];
}

@end
