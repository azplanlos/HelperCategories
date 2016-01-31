//
//  NSString+PathExtensions.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 20.01.16.
//  Copyright (c) 2016 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSString+PathExtensions.h"

@implementation NSString (PathExtensions)

-(NSString*)stringByDeletingRootPathComponent {
    NSMutableString* string = [NSMutableString new];
    NSArray* comps = [self pathComponents];
    for (int i = 2; i < comps.count; i++) {
        if (string.length > 0) [string appendFormat:@"/%@", [comps objectAtIndex:i]]; else [string appendString:[comps objectAtIndex:i]];
    }
    return [NSString stringWithString:string];
}

-(NSInteger)identicalParentPathComponentsInPath:(NSString *)comparePath {
    NSArray* ownPathComponents = [self pathComponents];
    NSArray* comparePathComponents = [comparePath pathComponents];
    NSInteger maxPathComps = (ownPathComponents.count < comparePathComponents.count) ? ownPathComponents.count : comparePathComponents.count;
    NSInteger identicalPathComponents = 0;
    for (NSInteger i = 0; i < maxPathComps; i++) {
        if (identicalPathComponents == i && [[ownPathComponents objectAtIndex:i] isEqualToString:[comparePathComponents objectAtIndex:i]]) identicalPathComponents++;
    }
    return identicalPathComponents;
}

@end
