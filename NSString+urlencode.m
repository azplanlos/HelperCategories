//
//  NSString+urlencode.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 21.07.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSString+urlencode.h"

@implementation NSString (NSString_Extended)

- (NSString *)urlencodeWithoutCharactersInSet:(NSCharacterSet*)charset {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            if ([charset characterIsMember:thisChar]) [output appendFormat:@"%c", thisChar]; else [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9') || [charset characterIsMember:thisChar]) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

-(NSString*)urlencode {
    return [self urlencodeWithoutCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@""]];
}

@end
