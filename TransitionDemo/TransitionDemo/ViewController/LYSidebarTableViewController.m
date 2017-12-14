//
//  LYSidebarTableViewController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYSidebarTableViewController.h"
#import "LYViewControllerTransitioningDelegate.h"
#import "LYTransitionAnimaterDataSource.h"

@interface LYSidebarTableViewController () <LYSidebarAnimaterDelegate>

@property (nonatomic, strong) LYViewControllerTransitioningDelegate *transitionDelegate;

@end

@implementation LYSidebarTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.transitionDelegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (CGFloat)movementDistance
{
    return [UIScreen mainScreen].bounds.size.width * 9 / 16;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (LYViewControllerTransitioningDelegate *)transitionDelegate
{
    if (!_transitionDelegate) {
        _transitionDelegate = [[LYViewControllerTransitioningDelegate alloc] initWithAnimationClassString:@"LYSidebarAnimater"];
    }
    
    return _transitionDelegate;
}

@end
