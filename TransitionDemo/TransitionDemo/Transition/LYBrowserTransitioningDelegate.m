//
//  LYBrowserTransitioningDelegate.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/30.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYBrowserTransitioningDelegate.h"

const CGFloat kBrowserAnimateDuration = 0.35;

@implementation LYBrowserAnimatorModle

+ (instancetype)initWithOriginRect:(CGRect)originRect targetRect:(CGRect)targetRect image:(UIImage *)image
{
    LYBrowserAnimatorModle *model = [LYBrowserAnimatorModle new];
    model.originRect = originRect;
    model.targetRect = targetRect;
    model.image = image;
    return model;
}

@end

@interface LYBrowserTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, copy) LYBrowserAnimatorModle *(^animatorData)(void);

@end

@implementation LYBrowserTransitionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return kBrowserAnimateDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromViewController;
    UIView *fromView;
    
    UIViewController *toViewController;
    UIView *toView;
    
    fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromView = fromViewController.view;
    
    toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toView = toViewController.view;
    
    CGRect startRect;
    CGRect endRect;
    LYBrowserAnimatorModle *data = self.animatorData();
    
    if (toViewController.isBeingPresented) {
        startRect = data.originRect;
        endRect = data.targetRect;
        toView.hidden = YES;
        
        [containerView addSubview:toView];
    } else {
        startRect = data.targetRect;
        endRect = data.originRect;
        fromView.hidden = YES;
    }
    
    UIView *backView = [self backViewWithRect:containerView.bounds];
    backView.alpha = !toViewController.isBeingPresented;
    UIImageView *imageView = [self imageViewWithRect:startRect];
    
    [containerView addSubview:backView];
    [containerView addSubview:imageView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = endRect;
        backView.alpha = toViewController.beingPresented;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        
        [backView removeFromSuperview];
        [imageView removeFromSuperview];
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (UIImageView *)imageViewWithRect:(CGRect)rect
{
    LYBrowserAnimatorModle *data = self.animatorData();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:data.image];
    imageView.frame = rect;
    return imageView;
}

- (UIView *)backViewWithRect:(CGRect)rect
{
    UIView *backView = [[UIView alloc] initWithFrame:rect];
    backView.backgroundColor = [UIColor blackColor];
    return backView;
}

@end

#pragma mark - LYBrowserTransitioningDelegate

@interface LYBrowserTransitioningDelegate ()

@property (nonatomic, strong) LYBrowserAnimatorModle *animatorModle;

@end

@implementation LYBrowserTransitioningDelegate

- (instancetype)initWithAnimatorData:(LYBrowserAnimatorModle *)dataModel
{
    if (self = [super init]) {
        _animatorModle = dataModel;
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self animator];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self animator];
}

- (LYBrowserTransitionAnimator *)animator
{
    LYBrowserTransitionAnimator *animator = [LYBrowserTransitionAnimator new];
    animator.animatorData = ^LYBrowserAnimatorModle *{
        return _animatorModle;
    };
    return animator;
}

@end
