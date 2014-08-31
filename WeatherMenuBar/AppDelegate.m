//
//  AppDelegate.m
//  WeatherMenuBar
//
//  Created by Torsten Wauer on 17/08/14.
//  Copyright (c) 2014 twdorado. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    [self update];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
}

- (void) update
{
    NSURL *url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=Dresden"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        _statusItem.title = @"- °C";
    }
    else{
        NSNumber *temp =[[weather objectForKey:@"main"] objectForKey:@"temp"];
        float t = [temp floatValue] - 273.15;
        _statusItem.title = [NSString stringWithFormat:@"%.1f °C",t];
        NSLog(@"%f",t);
    }
    
}


@end
