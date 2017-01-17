//
//  NSApplication+queueSheets.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 17.01.16.
//  Copyright (c) 2016 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "SISheetQueue.h"
#import "NSTimer+BBlock.h"
#import "NSAlert+BBlock.h"
#import "NSThread+Blocks.h"

@implementation SISheetQueue

static SISheetQueue* _sisheetqueue;

+(SISheetQueue*)sharedQueue {
    @synchronized([SISheetQueue class]) {
        if (!_sisheetqueue) _sisheetqueue = [[self alloc] init];
        return _sisheetqueue;
    }
    return nil;
}

+(id)alloc {
    @synchronized([SISheetQueue class]) {
        NSAssert(_sisheetqueue == nil, @"Attempted to allocate a second instance of a singleton.");
        _sisheetqueue = [super alloc];
        return _sisheetqueue;
    }   return nil;
}

-(id)init {
    self = [super init];
    if (self) {
        activeWindows = [NSMutableDictionary new];
        lastSheetQueue = [NSDate distantPast];
    }
    return self;
}

-(void)queueSheet:(id)sheet modalForWindow:(NSWindow *)modalWindow completionHandler:(void (^)(NSInteger returnCode))handler {
    if (modalWindow && ![activeWindows objectForKey:modalWindow.identifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sheetDismissed:) name:NSWindowDidEndSheetNotification object:modalWindow];
        NSMutableArray* panelCacheArray = [NSMutableArray new];
        [activeWindows setObject:panelCacheArray forKey:modalWindow.identifier];
    }
    if (((modalWindow && !modalWindow.attachedSheet) || !modalWindow) && [lastSheetQueue timeIntervalSinceDate:[NSDate date]] <= -1) {
#ifdef __DEBUG__
        NSLog(@"present sheet %@ for %@", sheet, modalWindow.identifier);
#endif
        [self presentSheet:sheet modalForWindow:modalWindow completionHandler:handler];
    } else {
        NSDictionary* saveDict;
#ifdef __DEBUG__
        NSLog(@"save sheet");
#endif
        if (handler) saveDict = @{@"sheet": sheet, @"handler": [handler copy]}; else saveDict = @{@"sheet": sheet};
        [[activeWindows objectForKey:modalWindow.identifier] addObject:saveDict];
    }
    lastSheetQueue = [NSDate date];
}

-(void)sheetDismissed:(NSNotification*)notification {
    if (((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)notification.object).identifier]).count > 0) {
        if (((NSWindow*)notification.object).attachedSheet == nil) {
            NSDictionary* nextSheetDict = [((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)notification.object).identifier]) objectAtIndex:0];
            [((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)notification.object).identifier]) removeObjectAtIndex:0];
            [NSTimer scheduledTimerWithTimeInterval:0.5 andBlock:^{
                [self presentSheet:[nextSheetDict valueForKey:@"sheet"] modalForWindow:notification.object completionHandler:[nextSheetDict valueForKey:@"handler"]];
            }];
        } else {
#ifdef __DEBUG__
            NSLog(@"sheet not ordered out!");
#endif
        }
    }
}

-(void)presentSheet:(id)sheet modalForWindow:(NSWindow *)modalWindow completionHandler:(void (^)(NSInteger returnCode))handler {
#ifdef __DEBUG__
    if (!handler) {
        NSLog(@"no handler for sheet %@ complete!", sheet);
    }
#endif
    if (modalWindow && modalWindow.isVisible) {
        if ([NSThread currentThread] != [NSThread mainThread]) {
            if ([sheet isKindOfClass:[NSAlert class]]) {
                [[NSThread mainThread] performBlock:^{
                    [((NSAlert*)sheet) beginSheetModalForWindow:modalWindow completionHandler:handler contextInfo:NULL];
                } waitUntilDone:NO];
            } else if ([sheet isKindOfClass:[NSWindow class]]) {
                [[NSThread mainThread] performBlock:^{
                    [NSApp beginSheet:sheet modalForWindow:modalWindow completionHandler:handler];
                } waitUntilDone:NO];
            } else {
                [[NSThread mainThread] performBlock:^{
                    [(NSSavePanel*)sheet beginSheetModalForWindow:modalWindow completionHandler:handler];
                } waitUntilDone:NO];
            }
        } else {
            if ([sheet isKindOfClass:[NSAlert class]]) {
                [((NSAlert*)sheet) beginSheetModalForWindow:modalWindow completionHandler:handler contextInfo:NULL];
            } else if ([sheet isKindOfClass:[NSWindow class]]) {
                [NSApp beginSheet:sheet modalForWindow:modalWindow completionHandler:handler];
            } else {
                [(NSSavePanel*)sheet beginSheetModalForWindow:modalWindow completionHandler:handler];
            }
        }
    } else {
        __block NSInteger button;
        if ([sheet isKindOfClass:[NSAlert class]]) {
            if ([NSThread currentThread] != [NSThread mainThread]) {
                [[NSThread mainThread] performBlock:^{
                    button = [(NSAlert*)sheet runModal];
                } waitUntilDone:YES];
            } else {
                button = [(NSAlert*)sheet runModal];
            }
        } else if ([sheet isKindOfClass:[NSWindow class]]) {
            if ([NSThread currentThread] != [NSThread mainThread]) {
                [[NSThread mainThread] performBlock:^{
                    [sheet makeKeyAndOrderFront:self];
                    button = [NSApp runModalForWindow:sheet];
                } waitUntilDone:YES];
            } else {
                [sheet makeKeyAndOrderFront:self];
                button = [NSApp runModalForWindow:sheet];
            }
        } else {
            if ([NSThread currentThread] != [NSThread mainThread]) {
                [[NSThread mainThread] performBlock:^{
                    button = [(NSSavePanel*)sheet runModal];
                } waitUntilDone:YES];
            } else {
                button = [(NSSavePanel*)sheet runModal];
            }
        }
        if (handler) handler(button);
    }
}

-(BOOL)queuedSheetsForWindow:(NSWindow *)modalWindow {
    if ([[activeWindows objectForKey:modalWindow.identifier] count] > 0) {
        return YES;
    }
    return NO;
}
    
-(BOOL)dismissSheet:(id)sheet onWindow:(NSWindow *)modalWindow {
    if (modalWindow.attachedSheet == sheet) {
        if ([NSThread currentThread] != [NSThread mainThread]) {
            [[NSThread mainThread] performBlock:^{
                [NSApp endSheet:sheet];
                [sheet orderOut:self];
                if ([NSApp modalWindow] != nil) {
                    [NSApp stopModal];
                }
                [NSThread sleepForTimeInterval:1];
            } waitUntilDone:YES];
        } else {
            [NSApp endSheet:sheet];
            [sheet orderOut:self];
            if ([NSApp modalWindow] != nil) {
                [NSApp stopModal];
            }
            [NSThread sleepForTimeInterval:1];
        }
        return YES;
    } else {
        NSInteger index = 0;
        NSInteger sheetIndex = -1;
        for (id queuedSheetDic in [activeWindows objectForKey:modalWindow.identifier]) {
            if ([queuedSheetDic objectForKey:@"sheet"] == sheet && sheetIndex == -1) {
                sheetIndex = index;
            }
            index++;
        }
        if (sheetIndex >= 0) {
            [((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)modalWindow).identifier]) removeObjectAtIndex:sheetIndex];
            return YES;
        }
        
    }
    return NO;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
