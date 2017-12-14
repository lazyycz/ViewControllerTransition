//
//  LYViewControllerTransitioningDelegate.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYViewControllerTransitioningDelegate.h"
#import "LYTransitionAnimater.h"
#import "LYSidebarPresentationController.h"

#define kAnimateDuration 0.35;

@interface LYViewControllerTransitioningDelegate ()

@property (nonatomic, copy) NSString *animationClass;
@property (nonatomic) NSTimeInterval duration;

@end

@implementation LYViewControllerTransitioningDelegate

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [LYTransitionAnimater animationerWithClassString:self.animationClass animateDuration:self.duration];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [LYTransitionAnimater animationerWithClassString:self.animationClass animateDuration:self.duration];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return [[LYSidebarPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

#pragma mark - init

- (instancetype)initWithAnimationClassString:(NSString *)animationClass
{
    return [self initWithAnimationClassString:animationClass animatDuration:0.0f];
}

- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatDuration:(NSTimeInterval)duration
{
    if (self = [super init]) {
        _animationClass = animationClass;
        _duration = duration > 0 ? duration : kAnimateDuration;
    }
    
    return self;
}

@end
