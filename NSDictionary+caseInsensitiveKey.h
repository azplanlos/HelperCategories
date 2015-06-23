//
//  NSObject+caseInsensitiveKey.h
//  Photoroute
//
//  Created by Andreas Zöllner on 23.06.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (caseInsensitiveKey)
-(id)valueForCaseInsensitiveKey:(NSString*)key;
@end
