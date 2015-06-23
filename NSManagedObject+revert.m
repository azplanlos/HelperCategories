//
//  NSManagedObject+revert.m
//  RC Manager
//
//  Created by Andreas Zöllner on 27.03.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSManagedObject+revert.h"

@implementation NSManagedObject (revert)

-(void)revertValueForKey:(NSString *)key {
    NSDictionary *changedValues = [self changedValues];
    NSDictionary *committedValues = [self committedValuesForKeys:[changedValues allKeys]];
    NSEnumerator *enumerator;

    enumerator = [changedValues keyEnumerator];
    NSString* changeKey;
    while (changeKey = [enumerator nextObject]) {
        if ([changeKey isEqualToString:key]) {
            NSLog(@"Reverting field ""%@"" from ""%@"" to ""%@""", key, [changedValues objectForKey:key], [committedValues objectForKey:key]);
            [self setValue:[committedValues objectForKey:key] forKey:key];
        }
    }
}
@end
