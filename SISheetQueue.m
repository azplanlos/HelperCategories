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
    }
    return self;
}

-(void)queueSheet:(id)sheet modalForWindow:(NSWindow *)modalWindow completionHandler:(void (^)(NSInteger returnCode))handler {
    if (![activeWindows objectForKey:modalWindow.identifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sheetDismissed:) name:NSWindowDidEndSheetNotification object:modalWindow];
        NSMutableArray* panelCacheArray = [NSMutableArray new];
        [activeWindows setObject:panelCacheArray forKey:modalWindow.identifier];
    }
    if (!modalWindow.attachedSheet) {
        [self presentSheet:sheet modalForWindow:modalWindow completionHandler:handler];
    } else {
        NSDictionary* saveDict;
        if (handler) saveDict = @{@"sheet": sheet, @"handler": [handler copy]}; else saveDict = @{@"sheet": sheet};
        [[activeWindows objectForKey:modalWindow.identifier] addObject:saveDict];
    }
}

-(void)sheetDismissed:(NSNotification*)notification {
    if (((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)notification.object).identifier]).count > 0) {
        NSDictionary* nextSheetDict = [((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)notification.object).identifier]) objectAtIndex:0];
        [((NSMutableArray*)[activeWindows objectForKey:((NSWindow*)notification.object).identifier]) removeObjectAtIndex:0];
        [NSTimer scheduledTimerWithTimeInterval:0.5 andBlock:^{
            [self presentSheet:[nextSheetDict valueForKey:@"sheet"] modalForWindow:notification.object completionHandler:[nextSheetDict valueForKey:@"handler"]];
        }];
    }
}

-(void)presentSheet:(id)sheet modalForWindow:(NSWindow *)modalWindow completionHandler:(void (^)(NSInteger returnCode))handler {
    if (modalWindow.isVisible) {
        if ([sheet isKindOfClass:[NSAlert class]]) {
            [((NSAlert*)sheet) beginSheetModalForWindow:modalWindow completionHandler:handler contextInfo:NULL];
        } else if ([sheet isKindOfClass:[NSWindow class]]) {
            [NSApp beginSheet:sheet modalForWindow:modalWindow completionHandler:handler];
        } else {
            [(NSSavePanel*)sheet beginSheetModalForWindow:modalWindow completionHandler:handler];
        }
    } else {
        if ([sheet isKindOfClass:[NSAlert class]]) {
            NSInteger button = [(NSAlert*)sheet runModal];
            handler(button);
        } else if ([sheet isKindOfClass:[NSWindow class]]) {
            [sheet makeKeyAndOrderFront:self];
            NSInteger button = [NSApp runModalForWindow:sheet];
            handler(button);
        } else {
            NSInteger button = [(NSSavePanel*)sheet runModal];
            handler(button);
        }
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
