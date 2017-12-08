//
//  LYDataModel.m
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "LYDataModel.h"

@implementation LYDataModel

+ (instancetype)initWithName:(NSString *)name classString:(NSString *)class
{
    LYDataModel *data = [[LYDataModel alloc] init];
    data.name = name;
    data.classString = class;
    return data;
}

@end
