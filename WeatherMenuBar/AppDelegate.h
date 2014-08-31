//
//  AppDelegate.h
//  WeatherMenuBar
//
//  Created by Torsten Wauer on 17/08/14.
//  Copyright (c) 2014 twdorado. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, CLLocationManagerDelegate>{
    
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    
    CLLocationManager *locationManager;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) quit:(id)sender;

@end
