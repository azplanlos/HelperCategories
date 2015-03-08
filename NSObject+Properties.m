//
//  NSObject+Properties.m
//  Photoroute
//
//  Created by Andreas Zöllner on 31.10.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>


@implementation NSObject (Properties)



- (NSArray *)allPropertyNames
{
    Class levelClass = [self class];
    NSMutableArray *rv = [NSMutableArray array];
    do {
        unsigned count;
        objc_property_t *properties = class_copyPropertyList(levelClass, &count);
        unsigned i;
        for (i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            [rv addObject:name];
        }
        free(properties);
        levelClass = class_getSuperclass(levelClass);
    } while (levelClass);
    return rv;
}

@end
