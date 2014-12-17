//
//  SIPRRectArray.m
//  Photoroute
//
//  Created by Programmierer on 5/10/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import "SIPRRectArray.h"

@implementation SIPRRectArray

-(SIPRRectArray*)init {
    self = [super init];
    rect = [[NSMutableArray alloc] init];
    return self;
}

-(void)addRect:(NSRect)newRect {
    [rect addObject:[NSValue valueWithRect:newRect]];
}

-(BOOL)intersectsWithRect:(NSRect)checkRect {
    BOOL intersect = NO;
    for (NSValue* elem in rect) {
        NSRect elemVal = [elem rectValue];
        if (NSIntersectsRect(checkRect, elemVal)) {
            // origin within rect
            intersect = YES;
            break;
        }
    }
    return intersect;
}


@end
