//
//  NSThread+Blocks.m
//  Shopify_Mobile
//
//  Created by Matthew Newberry on 9/3/10.
//  Copyright 2010 Shopify. All rights reserved.
//

#ifndef __IPHONE_4_0
#import <dispatch/dispatch.h>
#endif

@interface NSThread (BlocksAdditions)
- (void)performBlock:(void (^)())block;
- (void)performBlock:(void (^)())block waitUntilDone:(BOOL)wait;
+ (void)performBlockInBackground:(void (^)())block;
+ (void)performBlockOnMainThread:(void (^)())block;

@end