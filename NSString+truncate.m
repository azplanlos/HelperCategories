//
//  NSString+truncate.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 06.06.16.
//  Copyright (c) 2016 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSString+truncate.h"

@implementation NSString (truncate)

-(NSString*)stringByTruncatingToWidh:(CGFloat)width attributes:(NSDictionary *)textFontAttributes startAtPercent:(CGFloat)startperc {
    CGSize size = [self sizeWithAttributes:textFontAttributes];
    if (size.width <= width) return self;
    if (startperc > 1) startperc = 1;
    for (int i = 2; i < self.length; i+=2) {
        
        int endofPart1 = (self.length*startperc) - (i/2);
        int startofPart2 = (self.length*startperc) + (i/2);
        
        NSString* part1 = @"";
        NSString* part2 = @"";
        if (endofPart1 > 0) part1 = [self substringToIndex:endofPart1];
        if (startofPart2 < self.length) part2 = [self substringFromIndex:startofPart2];
        
        NSString* testString = [NSString stringWithFormat:@"%@...%@", part1, part2];
        CGSize size = [testString sizeWithAttributes:textFontAttributes];
        if (size.width <= width) return testString;
    }
    return @"";
}

@end
