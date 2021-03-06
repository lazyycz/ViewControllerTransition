//
//  LYDataModel.h
//  TransitionDemo
//
//  Created by Stone.Yu on 2017/12/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYDataModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *action;

+ (instancetype)initWithName:(NSString *)name action:(NSString *)action;

@end
