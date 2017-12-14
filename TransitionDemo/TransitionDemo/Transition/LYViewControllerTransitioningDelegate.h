//
//  LYViewControllerTransitioningDelegate.h
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYViewControllerTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithAnimationClassString:(NSString *)animationClass;
- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatDuration:(NSTimeInterval)duration;

@end
