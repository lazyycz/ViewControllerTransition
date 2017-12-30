//
//  LYBrowserTransitioningDelegate.h
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/30.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYBrowserAnimatorModle : NSObject

@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign) CGRect targetRect;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)initWithOriginRect:(CGRect)originRect targetRect:(CGRect)targetRect image:(UIImage *)image;

@end

@interface LYBrowserTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

- (instancetype)initWithAnimatorData:(LYBrowserAnimatorModle *)dataModel;

@end
