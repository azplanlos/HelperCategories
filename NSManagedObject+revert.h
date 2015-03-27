//
//  NSManagedObject+revert.h
//  RC Manager
//
//  Created by Andreas Zöllner on 27.03.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (revert)

-(void)revertValueForKey:(NSString*)key;

@end
