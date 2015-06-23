//
//  NSObject+caseInsensitiveKey.m
//  Photoroute
//
//  Created by Andreas Zöllner on 23.06.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSDictionary+caseInsensitiveKey.h"

@implementation NSDictionary (caseInsensitiveKey)

-(id)valueForCaseInsensitiveKey:(NSString*)key {
    NSPredicate *searchPred=[NSPredicate predicateWithFormat:@"self LIKE[cd] %@",key];
    NSArray *searchedKeys=[[self allKeys] filteredArrayUsingPredicate:searchPred];
    
    if(searchedKeys.count>0){
        return [self objectForKey:[searchedKeys objectAtIndex:0]];
    }
    return nil;
}

@end
