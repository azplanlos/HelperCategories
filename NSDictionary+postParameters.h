//
//  NSDictionary+postParameters.h
//  exchangeExport
//
//  Created by Andreas Zöllner on 27.06.16.
//  Copyright (c) 2016 Studio Istanbul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (postParameters)
- (NSData *)httpBodyForParamsDictionary;
@end
