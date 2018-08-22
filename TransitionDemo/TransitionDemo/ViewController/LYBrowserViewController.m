//
//  LYBrowserViewController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYBrowserViewController.h"
#import "UIView+Style.h"
#import "LYBrowserTransitioningDelegate.h"

@interface LYBrowserViewController ()

@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LYBrowserTransitioningDelegate *browserTransitioningDelegate;

@end

@implementation LYBrowserViewController

- (instancetype)initWithOriginRect:(CGRect)originRect
{
    if (self = [super init]) {
        _originRect = originRect;
        
        self.browserTransitioningDelegate = [[LYBrowserTransitioningDelegate alloc] initWithAnimatorData:[self animatorData]];
        self.transitioningDelegate = self.browserTransitioningDelegate;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalPresentationCapturesStatusBarAppearance = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:[self backgroundView]];
    [self.view addSubview:[self imageView]];
}

- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (LYBrowserAnimatorModle *)animatorData
{
    return [LYBrowserAnimatorModle initWithOriginRect:self.originRect targetRect:self.imageView.frame image:self.imageView.image];
}

- (UIControl *)backgroundView
{
    UIControl *backgroundView = [[UIControl alloc] initWithFrame:self.view.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    [backgroundView addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    return backgroundView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImage *image = [UIImage imageNamed:@"pic1"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, image.size.height * self.view.width / image.size.width)];
        _imageView.center = self.view.center;
        _imageView.image = image;
        return _imageView;
    }
    
    return _imageView;
}

@end
