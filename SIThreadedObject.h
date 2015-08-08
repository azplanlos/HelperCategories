//
//  SIThreadedObject.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 08.08.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <unistd.h>

@interface SIThreadedObject : NSObject
@property (strong, nonatomic) NSThread* currentThread;
- (void)start;
- (void)stop;
@end