//
//  NSString+truncate.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 06.06.16.
//  Copyright (c) 2016 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (truncate)

-(NSString*)stringByTruncatingToWidh:(CGFloat)width attributes:(NSDictionary*) textFontAttributes startAtPercent:(CGFloat)startperc;

@end
