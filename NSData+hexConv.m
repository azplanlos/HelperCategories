//
//  NSData+hexConv.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 21.07.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSData+hexConv.h"

@implementation NSData (NSData_Conversion)

#pragma mark - String Conversion

+(NSData*)dataWithHexString:(NSString *)hexString {
        NSString* string = [hexString lowercaseString];
        NSMutableData *data= [NSMutableData new];
        unsigned char whole_byte;
        char byte_chars[3] = {'\0','\0','\0'};
        int i = 0;
        int length = (int)string.length;
        while (i < length-1) {
            char c = [string characterAtIndex:i++];
            if (c < '0' || (c > '9' && c < 'a') || c > 'f')
                continue;
            byte_chars[0] = c;
            byte_chars[1] = [string characterAtIndex:i++];
            whole_byte = strtol(byte_chars, NULL, 16);
            [data appendBytes:&whole_byte length:1];
        }
        return data;
}

- (NSString *)hexadecimalString {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

@end
