//
//  SIPRRectArray.h
//  Photoroute
//
//  Created by Programmierer on 5/10/2013.
//  Copyright (c) 2013 Studio Istanbul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIPRRectArray : NSObject {
    NSMutableArray* rect;
}

-(void)addRect:(NSRect)rect;
-(BOOL)intersectsWithRect:(NSRect)rect;
@end
