//
//  NSString+CapitalizedString.m
//  Photoroute
//
//  Created by Andreas Zöllner on 18.11.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSString+CapitalizedString.h"

@implementation NSString (CapitalizedString)
-(NSString*)stringWithFirstLetterCapitalized {
    NSString *capitalisedSentence;
    
    //Does the string live in memory and it has atleast one letter?
    if (self && [self length]>0) {
        //Yes. It is
        
        capitalisedSentence = [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                  withString:[[self substringToIndex:1] capitalizedString]];
    }
    else{
        //No
        
    }
    return capitalisedSentence;
}

-(NSString*)stringGroupedByNumberOfLetters:(int)numberOfLetters withDelimiterString:(NSString*)delimiter {
    NSMutableString* retStr = [NSMutableString new];
    for (int i = 0; i < self.length-numberOfLetters; i += numberOfLetters) {
        if (i != 0) [retStr appendString:delimiter];
        [retStr appendString:[self substringWithRange:NSMakeRange(i, numberOfLetters)]];
        if (i + numberOfLetters > self.length-numberOfLetters) {
            // rest string
            [retStr appendString:delimiter];
            [retStr appendString:[self substringWithRange:NSMakeRange(i+numberOfLetters, self.length-(i+numberOfLetters))]];
        }
    }
    return [NSString stringWithString:retStr];
}
@end
