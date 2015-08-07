//
//  NSWindow+modalSheet.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 07.08.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSWindow+modalSheet.h"

@implementation NSWindow (modalSheet)
-(IBAction)stopModalSheet:(id)sender {
    [NSApp stopModal];
    [self orderOut: nil];
    [[NSApplication sharedApplication] endSheet:self returnCode:((NSButton*)sender).tag];
}

-(void)waitForSheetsToEnd {
    while (self.attachedSheet != nil) {
        [NSThread sleepForTimeInterval:0.5];
    }
}
@end
