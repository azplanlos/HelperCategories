//
//  NSString+Encode.m
//  exchangeExport
//
//  Created by AVID Editor on 10/9/12.
//  Copyright (c) 2012 Studio Istanbul. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (encode)
- (NSString *)encodeString:(NSStringEncoding)encoding
{
    NSString* retstr = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                                                              (CFStringRef)@"&=,", (CFStringRef)@";/?:@$+{}<>",
                                                                                              CFStringConvertNSStringEncodingToEncoding(encoding)));
    NSString* xstr = [NSString stringWithString:retstr];
    return xstr;
}  
@end
