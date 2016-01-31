//
//  NSString+PathExtensions.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 20.01.16.
//  Copyright (c) 2016 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PathExtensions)

-(NSString*)stringByDeletingRootPathComponent;
-(NSInteger)identicalParentPathComponentsInPath:(NSString*)comparePath;

@end
