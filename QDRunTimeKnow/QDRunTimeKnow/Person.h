//
//  Person.h
//  QDRunTimeKnow
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    // 成员变量声明
    int _age;
    NSString * _name;
    NSString * _address;
    int _sid;// 编号
    float _height;
    NSArray * _cars;
    double _weight;// 体重
}
@property (nonatomic,assign) int age;
// 声明属性
- (void)setName:(NSString *)name;
- (NSString *)name;

@property (nonatomic,copy) NSString * address;

- (void)setSid:(int)sid;
- (int)sid;

- (void)runWithSpeed:(int)speed;
- (void)jumpWithHeight:(float)height;
@end
