//
//  NSString+Hex.h
//  exchangeExport
//
//  Created by Andreas Zöllner on 22/09/16.
//  Copyright © 2016 Studio Istanbul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex)

- (NSData *) decodeFromHexidecimal;

@end
