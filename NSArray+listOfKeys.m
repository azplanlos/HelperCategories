//
//  NSArray+listOfKeys.m
//  Photoroute
//
//  Created by Andreas Zöllner on 31.10.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSArray+listOfKeys.h"
#import "NSString+urlencode.h"

@implementation NSArray (listOfKeys)

-(NSString*)commaSeparatedListWithQuoteString:(NSString *)quote {
    NSMutableString* retStr = [NSMutableString string];
    int i = 0;
    for (NSString* prop in self) {
        if (i != 0) {
            [retStr appendString:@","];
        }
        [retStr appendFormat:@"%@%@%@", quote, prop, quote];
        i++;
    }
    return retStr;
}

-(NSString*)commaSeparatedLowerCaseListWithSeparatorString:(NSString *)sep andQuoteString:(NSString*)quote {
    NSMutableString* retStr = [NSMutableString string];
    int i = 0;
    for (NSString* prop in self) {
        if (i != 0) {
            [retStr appendString:sep];
        }
        [retStr appendFormat:@"%@%@%@", quote, [prop lowercaseString], quote];
        i++;
    }
    return retStr;
}

-(NSString*)commaSeparatedURIEncodedListWithSeparatorString:(NSString *)sep andQuoteString:(NSString*)quote andUnencodedCharacters:(NSCharacterSet*)charset {
    NSMutableString* retStr = [NSMutableString string];
    int i = 0;
    for (__strong NSString* prop in self) {
        if (i != 0) {
            [retStr appendString:sep];
        }
        if ([prop rangeOfString:@"="].location == NSNotFound && prop.length > 0) {
            prop = [NSString stringWithFormat:@"%@=", prop];
        }
        [retStr appendFormat:@"%@%@%@", quote, [prop urlencodeWithoutCharactersInSet:charset], quote];
        i++;
    }
    return retStr;
}

-(NSString*)commaSeparatedList {
    return [self commaSeparatedListWithQuoteString:@""];
}

@end

@implementation NSDictionary (listOfKeys)

-(NSString*)sortedCommaSeparatedLowerCaseListWithSeparatorString:(NSString *)sep andQuoteString:(NSString *)quote andValueAssignmentString:(NSString *)valString {
    NSMutableString* retStr = [NSMutableString string];
    int i = 0;
    for (NSString* key in [self.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]) {
        if (i != 0) {
            [retStr appendString:sep];
        }
        [retStr appendFormat:@"%@%@%@%@%@%@%@", quote, [key lowercaseString], quote, valString, quote, [self valueForKey:key], quote];
        i++;
    }
    return retStr;
}

@end
