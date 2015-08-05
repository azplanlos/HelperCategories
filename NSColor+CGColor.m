//
//  NSColor+CGColor.m
//
//  Created by Michael Sanders on 11/19/10.
//

#import "NSColor+CGColor.h"

@implementation NSColor (CGColor)

- (CGColorRef)CGColorRef
{
    const NSInteger numberOfComponents = [self numberOfComponents];
    CGFloat components[numberOfComponents];
    CGColorSpaceRef colorSpace = [[self colorSpace] CGColorSpace];
    
    [self getComponents:(CGFloat *)&components];
    
    return (__bridge CGColorRef)(__bridge id)CGColorCreate(colorSpace, components);
}

+ (NSColor *)colorWithCGColorRef:(CGColorRef)CGColor
{
    if (CGColor == NULL) return nil;
    return [NSColor colorWithCIColor:[CIColor colorWithCGColor:CGColor]];
}

@end
