//
//  NSTextField+Label.m
//  Photoroute
//
//  Created by Andreas Zöllner on 23.06.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSTextField+Label.h"

@implementation NSTextField (Label)

+(NSTextField*)labelWithString:(NSString *)contentString inFrame:(NSRect)labelRect {
    NSTextField* myLabel = [[NSTextField alloc] initWithFrame:labelRect];
    myLabel.stringValue = contentString;
    [myLabel setEditable:NO];
    [myLabel setSelectable:NO];
    [myLabel setDrawsBackground:NO];
    [myLabel setBezeled:NO];
    return myLabel;
}

@end
