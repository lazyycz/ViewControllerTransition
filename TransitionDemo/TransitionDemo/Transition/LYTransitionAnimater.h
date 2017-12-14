//
//  LYTransitionAnimater.h
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYTransitionAnimater : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id dataSource;

+ (instancetype)animationerWithClassString:(NSString *)classString animateDuration:(NSTimeInterval)duration;

@end
