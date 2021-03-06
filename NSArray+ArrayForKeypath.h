//
//  NSArray+ArrayForKeypath.h
//  Photoroute
//
//  Created by Andreas Zöllner on 12.11.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ArrayForKeypath)
-(NSArray*)arrayForValuesWithKey:(NSString*)key;
-(NSArray*)stringArrayForValuesWithKey:(NSString*)key;
-(NSArray*)flatStringArrayForValuesWithKey:(NSString*)key followingChildKey:(NSString*)childKey;
-(id)objectWithValue:(NSString*)value forKey:(NSString*)key andChildrenKey:(NSString*)childKey;
@end
