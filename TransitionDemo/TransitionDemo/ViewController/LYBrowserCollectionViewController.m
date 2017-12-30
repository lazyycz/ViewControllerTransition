//
//  LYBrowserCollectionViewController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYBrowserCollectionViewController.h"
#import "LYBrowserViewController.h"

@interface LYBrowserCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LYBrowserCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:({
            self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 90)];
            self.imageView.image = [UIImage imageNamed:@"pic1"];
            self.imageView;
        })];
    }
    
    return self;
}

@end

@interface LYBrowserCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation LYBrowserCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"浏览图片";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LYBrowserCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYBrowserCell *cell = (LYBrowserCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect originRect = [[cell superview] convertRect:cell.frame toView:self.view];
    
    LYBrowserViewController *vc = [[LYBrowserViewController alloc] initWithOriginRect:originRect];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
