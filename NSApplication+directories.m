//
//  NSApplication+directories.m
//  Photoroute
//
//  Created by Andreas Zöllner on 02.12.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSApplication+directories.h"
#include <sys/sysctl.h>

@implementation NSApplication (directories)

+(NSURL*)appSupportURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *libraryURL = [[[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:libraryURL.path]) {
        [[NSFileManager defaultManager] createDirectoryAtURL:libraryURL withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return libraryURL;
}

+ (NSString*) systemInfoString:(const char*)attributeName
{
    size_t size;
    sysctlbyname(attributeName, NULL, &size, NULL, 0); // Get the size of the data.
    char* attributeValue = malloc(size);
    int err = sysctlbyname(attributeName, attributeValue, &size, NULL, 0);
    if (err != 0) {
        NSLog(@"sysctlbyname(%s) failed: %s", attributeName, strerror(errno));
        free(attributeValue);
        return nil;
    }
    NSString* vs = [NSString stringWithUTF8String:attributeValue];
    free(attributeValue);
    return vs;
}

+ (NSString*) hostName
{
    NSArray* components = [[self systemInfoString:"kern.hostname"] componentsSeparatedByString:@"."];
    return [components objectAtIndex:0];
}


@end
