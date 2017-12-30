//
//  LYSidebarTableViewController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYSidebarTableViewController.h"
#import "LYSidebarTransitioningDelegate.h"

@interface LYSidebarTableViewController ()

@property (nonatomic, strong) LYSidebarTransitioningDelegate *sidebarTransitioningDelegate;

@end

@implementation LYSidebarTableViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    if (self = [super init]) {
        self.sidebarTransitioningDelegate = [LYSidebarTransitioningDelegate new];
        self.transitioningDelegate = self.sidebarTransitioningDelegate;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalPresentationCapturesStatusBarAppearance = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [NSString stringWithFormat:@"第 %@ 行", @(indexPath.row + 1)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
