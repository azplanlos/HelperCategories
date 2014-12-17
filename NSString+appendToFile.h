//
//  NSString+appendToFile.h
//  Photoroute
//
//  Created by Andreas Zöllner on 02.12.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (appendToFile)

-(void)appendToFileAtURL:(NSURL*)fileUrl;

@end
