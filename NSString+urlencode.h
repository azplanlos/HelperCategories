//
//  NSString+urlencode.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 21.07.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (urlencode)
- (NSString *)urlencode;
- (NSString *)urlencodeWithoutCharactersInSet:(NSCharacterSet*)charset;
- (NSString *)urldecode;
@end
