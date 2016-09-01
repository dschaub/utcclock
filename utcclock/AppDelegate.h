//
//  AppDelegate.h
//  utcclock
//
//  Created by Daniel Schaub on 8/28/16.
//  Copyright © 2016 Dan Schaub.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (void)updateDate;
- (void)wakeupNotification:(NSNotification*)notification;
- (void)sleepNotification:(NSNotification*)notification;

@end

