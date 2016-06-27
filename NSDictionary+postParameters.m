//
//  NSDictionary+postParameters.m
//  exchangeExport
//
//  Created by Andreas Zöllner on 27.06.16.
//  Copyright (c) 2016 Studio Istanbul. All rights reserved.
//

#import "NSDictionary+postParameters.h"
#import "NSString+Encode.h"

@implementation NSDictionary (postParameters)

- (NSData *)httpBodyForParamsDictionary
{
    NSMutableArray *parameterArray = [NSMutableArray array];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *param = [NSString stringWithFormat:@"%@=%@", key, [obj encodeString:NSUTF8StringEncoding]];
        [parameterArray addObject:param];
    }];
    
    NSString *string = [parameterArray componentsJoinedByString:@"&"];
    
    return [string dataUsingEncoding:NSASCIIStringEncoding];
}

@end
