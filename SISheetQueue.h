//
//  NSApplication+queueSheets.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 17.01.16.
//  Copyright (c) 2016 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSApplication+BBlock.h"

@interface SISheetQueue : NSObject {
    NSMutableDictionary* activeWindows;
}

+(SISheetQueue*)sharedQueue;

-(void)queueSheet:(id)sheet modalForWindow:(NSWindow *)modalWindow completionHandler:(void (^)(NSInteger returnCode))handler;
-(BOOL)queuedSheetsForWindow:(NSWindow*)modalWindow;

@end
