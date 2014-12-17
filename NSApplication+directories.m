//
//  NSApplication+directories.m
//  Photoroute
//
//  Created by Andreas Zöllner on 02.12.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSApplication+directories.h"

@implementation NSApplication (directories)

+(NSURL*)appSupportURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *libraryURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [libraryURL URLByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
}

@end
