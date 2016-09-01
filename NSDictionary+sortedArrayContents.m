//
//  NSDictionary+sortedArrayContents.m
//  exchangeExport
//
//  Created by Andreas Zöllner on 19/08/16.
//  Copyright © 2016 Studio Istanbul. All rights reserved.
//

#import "NSDictionary+sortedArrayContents.h"
#import "NSArray+containsString.h"

@implementation NSDictionary (sortedArrayContents)

-(NSArray*)valuesSortedByArrayOfKeys:(NSArray *)keysArray {
    NSMutableArray* retArray = [[NSMutableArray alloc] initWithCapacity:keysArray.count];
    for (NSString* key in keysArray) {
        [retArray addObject:[self valueForKey:key]];
    }
    return [NSArray arrayWithArray:retArray];
}

@end
