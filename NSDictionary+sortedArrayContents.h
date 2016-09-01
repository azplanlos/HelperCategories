//
//  NSDictionary+sortedArrayContents.h
//  exchangeExport
//
//  Created by Andreas Zöllner on 19/08/16.
//  Copyright © 2016 Studio Istanbul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (sortedArrayContents)

/**
 Returns a array of values sorted by occurence order of their keys in a NSArray.
 
 @param keysArray array of keys to return
 
 @return  Returns a array of values sorted by occurence order of their keys in a NSArray.
 
 @since 1.0
 */

-(NSArray*)valuesSortedByArrayOfKeys:(NSArray*)keysArray;

@end
