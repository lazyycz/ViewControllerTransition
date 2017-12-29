//
//  LYPanDirectionGestureRecognizer.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYPanDirectionGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface LYPanDirectionGestureRecognizer ()

@property (nonatomic, assign) LYPanGestureDirection direction;

@end

@implementation LYPanDirectionGestureRecognizer

-(id)initWithTarget:(id)target action:(SEL)action andDirection:(LYPanGestureDirection) direction
{
    if (self = [super initWithTarget:target action:action]) {
        _direction = direction;
    }
    
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if(self.state == UIGestureRecognizerStateBegan){
        CGPoint velocity =  [self velocityInView:self.view];
        switch (self.direction) {
            case LYPanGestureDirectionHorizontal: {
                if (fabs(velocity.y) > fabs(velocity.x)) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
            }
                break;
                
            case LYPanGestureDirectionVertical: {
                if (fabs(velocity.x) > fabs(velocity.y)) {
                    self.state = UIGestureRecognizerStateCancelled;
                }
            }
                break;
                
            default:
                break;
        }
    }
}

@end
