//
//  AppDelegate.m
//  utcclock
//
//  Created by Daniel Schaub on 8/28/16.
//  Copyright © 2016 Dan Schaub.com. All rights reserved.
//

#import "AppDelegate.h"

static NSStatusItem *statusItem;
static NSTimer *timer;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:[self menu]];
    
    [self createTimer];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter]
     addObserver:self
     selector:@selector(sleepNotification:)
     name:NSWorkspaceWillSleepNotification
     object:nil];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter]
     addObserver:self
     selector:@selector(wakeupNotification:)
     name:NSWorkspaceDidWakeNotification
     object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [timer invalidate];
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver: self];
}

- (void)updateDate {
    [[statusItem button] setTitle:[self currentDate]];
}

- (NSString*)currentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.dateFormat = @"HH:mm";
    NSDate *now = [NSDate date];
    return [[formatter stringFromDate:now] stringByAppendingString:@"Z"];
}

- (NSMenu*)menu {
    NSMenu *menu = [[NSMenu alloc] init];
    [menu setAutoenablesItems:NO];
    
    NSMenuItem *quitItem = [[NSMenuItem alloc] init];
    [quitItem setTitle:@"Quit"];
    [quitItem setTarget:[NSApplication sharedApplication]];
    [quitItem setAction:@selector(terminate:)];
    [quitItem setEnabled:YES];
    
    [menu addItem:quitItem];
    
    return menu;
}

- (void)createTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDate) userInfo:nil repeats:YES];
}

- (void)sleepNotification:(NSNotification *)notification {
    [timer invalidate];
}

- (void)wakeupNotification:(NSNotification *)notification {
    [self createTimer];
}

@end
