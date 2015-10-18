//
//  Person.m
//  QDRunTimeKnow
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)setName:(NSString *)name {
    _name = name;
}

- (NSString *)name {
    return _name;
}

- (void)setAddress:(NSString *)address {
    _address = address;
}

- (NSString *)address {
    return _address;
}

- (void)setSid:(int)sid {
    _sid = sid;
}

- (int)sid {
    return _sid;
}

- (void)runWithSpeed:(int)speed {
    [self eatWithFood:@"辣条"];
    NSLog(@"run with Speed %d",speed);
}

// 模拟私有方法
- (void)eatWithFood:(NSString *)name {
    NSLog(@"eat some %@",name);
}

- (void)jumpWithHeight:(float)height {
    NSLog(@"jump %f",height);
}


@end
