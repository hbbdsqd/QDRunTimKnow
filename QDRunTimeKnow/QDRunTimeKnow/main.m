//
//  main.m
//  QDRunTimeKnow
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"
// 如何获得一个类
Class obj_Class(id obj){
    Class class = object_getClass(obj);
    return class;
}

NSString * obj_ClassName(id obj) {
    // 获取类名字(c 字符串)
    const char * cName = object_getClassName(obj);
    // 转换
    return [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
}

// 3 获取一个类所有的方法
NSArray * obj_ClassMethodNames(id obj) {
    unsigned int count = 0;
    Method * methods = class_copyMethodList([obj class], &count);
    NSMutableArray * tmpArray = [NSMutableArray array];
    for (int i = 0; i <count; i++ ) {
        SEL method = method_getName(methods[i]);
        [tmpArray addObject:NSStringFromSelector(method)];
    }
    return tmpArray;
}

// 4 获得声明@ property 的所有的属性
NSArray * obj_PropertyNames(id obj) {
    unsigned int count = 0;
    objc_property_t * properties = class_copyPropertyList([obj class], &count);
    NSMutableArray * tmpArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char * property = property_getName(properties[i]);
        [tmpArray addObject:[NSString stringWithCString:property encoding:NSUTF8StringEncoding]];
    }
    return tmpArray;
}

// 5 获得全局变量的数据类型
void obj_ClassVarTypes(id obj){
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([obj class],&count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *cName = ivar_getTypeEncoding(ivar);
        NSString * typeName =[NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",typeName);
    }
    
}

// 6 获得某个全局变量的数据类型
void obj_vartype(id obj,char * varname){
    Ivar ivar = class_getInstanceVariable([obj class], varname);
    const char * cName = ivar_getTypeEncoding(ivar);
    NSString * type = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
    NSLog(@"%@",type);
}

// 7 获得具体属性的名字
NSString * obj_propertyVarName(id obj,char * propertyname) {
    
    objc_property_t property = class_getProperty([obj class], propertyname);
    const char * cName = property_getName(property);
    
    NSString * prop = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
    return prop;
}
// 8 执行 set 方法
// 字符串
void obj_invokeProperty(id obj, char * propertyname,id value) {
    // 1 判断属性是否存在
    NSString * name = obj_propertyVarName(obj, propertyname);
    if (name) {
        objc_property_t property = class_getProperty([obj class], propertyname);
        const char * attrsC = property_getAttributes(property);
        // 获得属性 ,属性的第一个元素是类型名
        NSString * attrs = [NSString stringWithCString:attrsC encoding:NSUTF8StringEncoding];
        NSLog(@"attrs %@",attrs);
        //        if([attrs containsString:@"NSString"]){
        // 拼接 set 方法名
        // 首字母大写
        NSString * upperName = [name capitalizedString];
        // 拼接 set
        //
        NSString * setName = [NSString stringWithFormat:@"set%@:",upperName];
        SEL sel = NSSelectorFromString(setName);
        [obj performSelector:sel withObject:value];
        
        //        }
        
    }
    
    
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person * p = [[Person alloc] init];
        // 示例1 获取类
        NSLog(@"%@",NSStringFromClass(obj_Class(p)));
        NSLog(@"%@",NSStringFromClass([p class]));
        // 示例2 获取类名
        NSLog(@"%@",obj_ClassName(p));
        // 示例3 获取所有的方法名
        NSLog(@"%@",obj_ClassMethodNames(p));
        // 示例4 获取所有的 property 属性
        // 只打印 property 声明的属性
        NSLog(@"%@",obj_PropertyNames(p));
        // 示例5 打印全局变量
        obj_ClassVarTypes(p);
        // 示例6 获得某个全局变量的类型名
        obj_vartype(p, "_cars");
        // 示例7 获得具体属性的名字
        NSLog(@"%@",obj_propertyVarName(p, "age"));
        // 示例8 执行 set 方法
        obj_invokeProperty(p, "address", @"beijing");
        NSLog(@"%@",p.address);
    }
    return 0;
}

