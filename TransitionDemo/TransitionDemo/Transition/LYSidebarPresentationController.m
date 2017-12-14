//
//  LYSidebarPresentationController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYSidebarPresentationController.h"

@interface LYSidebarPresentationController ()

@property (nonatomic, strong) UIControl *dimmingView;

@end

@implementation LYSidebarPresentationController

- (void)presentationTransitionWillBegin
{
    self.dimmingView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.dimmingView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.3;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews
{
    self.dimmingView.frame = self.containerView.bounds;
}

- (UIControl *)dimmingView
{
    if (!_dimmingView) {
        _dimmingView = [[UIControl alloc] init];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.alpha = 0;
        [_dimmingView addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dimmingView;
}

- (void)dismissViewController
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
