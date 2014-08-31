//
//  AppDelegate.h
//  WeatherMenuBar
//
//  Created by Torsten Wauer on 17/08/14.
//  Copyright (c) 2014 twdorado. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong, nonatomic) NSStatusItem *statusItem;

@end
