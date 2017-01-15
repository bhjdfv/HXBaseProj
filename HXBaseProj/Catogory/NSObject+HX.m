//
//  NSObject+HX.m
//  HXBaseProj
//
//  Created by 黄鑫 on 17/1/8.
//  Copyright © 2017年 Aizen. All rights reserved.
//

#import "NSObject+HX.h"
#import <objc/runtime.h>

@implementation NSObject (HX)

- (NSDictionary *)descriptionMehtod:(id)obj {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    u_int count;
    if (count >= 20) return nil;

    //获取所有的属性
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for (int i = 0; i<count; i++) {
        //得到属性的名称
        const char * propertyName = property_getName(properties[i]);
        id objValue;
        //将属性转化位字符串
        NSString * key = [NSString stringWithUTF8String:propertyName];
        //取值
        objValue = [obj valueForKey:key];
        if (objValue) {
            //写入字典中
            [dic setObject:objValue forKey:key];
        }
    }
    
    NSDictionary * dictionary = [dic copy];
    return dictionary;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self descriptionMehtod:self]];
}

-(NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p,%@>",
            [self class],
            self,
            [self descriptionMehtod:self]];
}

@end
