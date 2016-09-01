//
//  NSView+clone.m
//  exchangeExport
//
//  Created by Andreas Zöllner on 17.08.16.
//  Copyright (c) 2016 Studio Istanbul. All rights reserved.
//

#import "NSView+clone.h"

@implementation NSView (clone)

- (id) clone {
    NSData *archivedViewData = [NSKeyedArchiver archivedDataWithRootObject: self];
    id clone = [NSKeyedUnarchiver unarchiveObjectWithData:archivedViewData];
    return clone;
}

@end
