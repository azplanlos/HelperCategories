//
//  NSString+appendToFile.m
//  Photoroute
//
//  Created by Andreas Zöllner on 02.12.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSString+appendToFile.h"

@implementation NSString (appendToFile)

-(void)appendToFileAtURL:(NSURL *)fileUrl {
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileUrl.path]) [[NSFileManager defaultManager] createFileAtPath:fileUrl.path contents:nil attributes:nil];
    NSError* fileError = nil;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingToURL:fileUrl error:&fileError];
    if (!fileError) {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
}

@end
