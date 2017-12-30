//
//  LYTableViewController.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYTableViewController.h"
#import "LYSidebarTableViewController.h"
#import "LYBrowserCollectionViewController.h"
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
    
    _Pragma("clang diagnostic push")
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    LYDataModel *dataModel = self.dataSource[indexPath.row];
    if (dataModel.action.length) {
        SEL action = NSSelectorFromString(dataModel.action);
        if ([self respondsToSelector:action]) {
            [self performSelector:action withObject:dataModel];
        }
    }
    _Pragma("clang diagnostic pop")
}

- (void)gotoSidebarViewController
{
    LYSidebarTableViewController *vc = [LYSidebarTableViewController new];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)gotoBrowserViewController
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(100, 90);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    LYBrowserCollectionViewController *vc = [[LYBrowserCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData
{
    self.title = @"TransitionDemo";

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.dataSource = @[
                        [LYDataModel initWithName:@"侧边栏视图" action:NSStringFromSelector(@selector(gotoSidebarViewController))],
                        [LYDataModel initWithName:@"图片浏览器" action:NSStringFromSelector(@selector(gotoBrowserViewController))],
                        ];
}

@end
