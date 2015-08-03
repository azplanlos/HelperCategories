//
//  NSArray+listOfKeys.h
//  Photoroute
//
//  Created by Andreas Zöllner on 31.10.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (listOfKeys)

-(NSString*)commaSeparatedList;
-(NSString*)commaSeparatedListWithQuoteString:(NSString*)quote;
-(NSString*)commaSeparatedLowerCaseListWithSeparatorString:(NSString *)sep andQuoteString:(NSString*)quote;
-(NSString*)commaSeparatedURIEncodedListWithSeparatorString:(NSString *)sep andQuoteString:(NSString*)quote andUnencodedCharacters:(NSCharacterSet*)charset;
@end

@interface NSDictionary (listOfKeys)
-(NSString*)sortedCommaSeparatedLowerCaseListWithSeparatorString:(NSString *)sep andQuoteString:(NSString*)quote andValueAssignmentString:(NSString*)valString;
@end