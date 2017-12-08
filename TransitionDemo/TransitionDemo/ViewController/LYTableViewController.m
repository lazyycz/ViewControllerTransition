//
//  LYTableViewController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYTableViewController.h"
#import "LYDataModel.h"

@interface LYTableViewController ()

@property (nonatomic, strong) NSArray <LYDataModel *>*dataSource;

@end

@implementation LYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row].name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = NSClassFromString(self.dataSource[indexPath.row].classString);
    UIViewController *viewController = [[class alloc] init];
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}

- (void)initData
{
    self.title = @"TransitionDemo";

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.dataSource = @[[LYDataModel initWithName:@"侧边栏视图" classString:@"LYSidebarTableViewController"]];
}

@end
