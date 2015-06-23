//
//  NSTextField+Label.h
//  Photoroute
//
//  Created by Andreas Zöllner on 23.06.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextField (Label)

+(NSTextField*)labelWithString:(NSString*)contentString inFrame:(NSRect)labelRect;

@end
