//
//  emptyString.h
//  exchangeExport
//
//  Created by Andreas Zöllner on 16.12.17.
//  Copyright © 2017 Studio Istanbul. All rights reserved.
//

#ifndef emptyString_h
#define emptyString_h

#define emptyNull(string) string && string != (id)[NSNull null] && ![string isEqualToString:@"<null>"] ? string : @""

#endif /* emptyString_h */
