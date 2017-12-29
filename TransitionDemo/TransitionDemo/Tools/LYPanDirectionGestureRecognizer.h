//
//  LYPanDirectionGestureRecognizer.h
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LYPanGestureDirection) {
    LYPanGestureDirectionVertical,
    LYPanGestureDirectionHorizontal,
};

@interface LYPanDirectionGestureRecognizer : UIPanGestureRecognizer

-(id)initWithTarget:(id)target action:(SEL)action andDirection:(LYPanGestureDirection) direction;

@end
