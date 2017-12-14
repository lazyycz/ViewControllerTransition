//
//  LYTransitionAnimater.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYTransitionAnimater.h"

@interface LYTransitionAnimater ()

@property (nonatomic) NSTimeInterval duration;

@end

@implementation LYTransitionAnimater

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext { }


+ (instancetype)animationerWithClassString:(NSString *)classString animateDuration:(NSTimeInterval)duration
{
    if (!classString || !classString.length) {
        return nil;
    }
    
    LYTransitionAnimater *animater = nil;
    Class class = NSClassFromString(classString);
    if (class && [class isSubclassOfClass:[LYTransitionAnimater class]]) {
        animater = [[class alloc] init];
        animater.duration = duration;
    }
    
    return animater;
}

@end
