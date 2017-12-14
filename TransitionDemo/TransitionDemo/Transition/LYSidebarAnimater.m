//
//  LYSidebarAnimater.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYSidebarAnimater.h"
#import "UIView+Style.h"
#import "LYTransitionAnimaterDataSource.h"

#define kWidth ([UIScreen mainScreen].bounds.size.width / 2)

@implementation LYSidebarAnimater

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    
    id <LYSidebarAnimaterDelegate> dataSource = self.dataSource;
    CGFloat distance = [dataSource movementDistance];
    
    CGRect originRect = CGRectMake(containerView.width, 0, distance, containerView.height);
    CGRect targetRect = CGRectMake(containerView.width - distance, 0, distance, containerView.height);
    
    if (toViewController.isBeingPresented) {
        toView.frame = originRect;
        [containerView addSubview:toView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (toViewController.beingPresented) {
            toView.frame = targetRect;
        }
        else if (fromViewController.beingDismissed) {
            fromView.frame = originRect;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }
    }];
}

@end
