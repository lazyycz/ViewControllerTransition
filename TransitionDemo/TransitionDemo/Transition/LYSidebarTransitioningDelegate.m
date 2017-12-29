//
//  LYSidebarTransitioningDelegate.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYSidebarTransitioningDelegate.h"
#import "LYPanDirectionGestureRecognizer.h"
#import "UIView+Style.h"

const CGFloat kSidebarWidth = 260;
const CGFloat kAnimateDuration = 0.35;

#pragma mark -
#pragma mark - Animator

@interface LYMapSidebarTransitionAnimator: NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation LYMapSidebarTransitionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimateDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    
    CGRect originRect = CGRectMake(containerView.width, 0, kSidebarWidth, containerView.height);
    CGRect targetRect = CGRectMake(containerView.width - kSidebarWidth, 0, kSidebarWidth, containerView.height);
    
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
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end


#pragma mark -
#pragma mark - InteractiveTransition

@interface LYMapSidebarInteractiveTransition: UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;
- (void)wireToViewController:(UIViewController*)viewController;

@property (nonatomic, weak) UIViewController *presentedViewController;
@property (nonatomic, assign) CGFloat fraction;

@end

@implementation LYMapSidebarInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController
{
    self.presentedViewController = viewController;
    LYPanDirectionGestureRecognizer *panGestureRecognizer = [[LYPanDirectionGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:) andDirection: LYPanGestureDirectionHorizontal];
    [viewController.view addGestureRecognizer:panGestureRecognizer];
}

- (void)handleGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interacting = YES;
            [self.presentedViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [self updateInteractiveTransition:0];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat total, part;
            CGSize presentedViewSize = self.presentedViewController.view.bounds.size;
            
            total = presentedViewSize.width;
            part = translation.x;
            
            CGFloat fraction = part / total;
            self.fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            [self updateInteractiveTransition:self.fraction];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (!(self.fraction > 0.25) || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            self.interacting = NO;
        }
            break;
            
        default:
            break;
    }
}

@end


#pragma mark -
#pragma mark - PresentationController

@interface LYMapSidebarPresentationController : UIPresentationController

@property (nonatomic, strong) UIControl *shadeControl;

@end

@implementation LYMapSidebarPresentationController

- (void)presentationTransitionWillBegin
{
    self.shadeControl.frame = self.containerView.bounds;
    [self.containerView addSubview:self.shadeControl];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.shadeControl.alpha = 0.5;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.shadeControl.alpha = 0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews
{
    self.shadeControl.frame = self.containerView.bounds;
}

- (UIControl *)shadeControl
{
    if (!_shadeControl) {
        _shadeControl = [[UIControl alloc] init];
        _shadeControl.backgroundColor = [UIColor blackColor];
        _shadeControl.alpha = 0;
        [_shadeControl addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shadeControl;
}

- (void)dismissView:(UIGestureRecognizer *)gesture
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end


#pragma mark -
#pragma mark - TransitioningDelegate

@interface LYSidebarTransitioningDelegate ()

@property (nonatomic, strong) LYMapSidebarInteractiveTransition *interactionController;

@end

@implementation LYSidebarTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    LYMapSidebarTransitionAnimator *animator = [LYMapSidebarTransitionAnimator new];
    [self.interactionController wireToViewController:presented];
    return animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[LYMapSidebarTransitionAnimator alloc] init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactionController.interacting ? self.interactionController : nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return [[LYMapSidebarPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (LYMapSidebarInteractiveTransition *)interactionController
{
    if (!_interactionController) {
        _interactionController = [LYMapSidebarInteractiveTransition new];
    }
    
    return _interactionController;
}

@end
