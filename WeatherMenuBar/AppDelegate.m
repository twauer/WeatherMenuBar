//
//  AppDelegate.m
//  WeatherMenuBar
//
//  Created by Torsten Wauer on 17/08/14.
//  Copyright (c) 2014 twdorado. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    // set up status item and menu
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    
    // set up location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    [locationManager setDelegate:self];
    
    // set value first time
    [self update];
    
    // and execute it in a loop
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(update) userInfo:nil repeats:YES];

}

- (void) update
{

    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized: {
            
            // get current location
            CLLocation *location = locationManager.location;
            
            float lat = location.coordinate.latitude;
            float lon = location.coordinate.longitude;
            
            
            NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f",lat,lon];
            
            NSLog(@"%@",urlString);
            
            // get weather
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // update the temperature
            if (error) {
                statusItem.title = @"- °C";
            }
            else{
                NSNumber *temp =[[json objectForKey:@"main"] objectForKey:@"temp"];
                float t = [temp floatValue] - 273.15;
                statusItem.title = [NSString stringWithFormat:@"%.1f °C",t];
                NSLog(@"%f",t);
            }
            
            // update location in menu
            NSMenuItem *item = [statusMenu itemAtIndex:0];
            
            NSString *name = [json objectForKey:@"name"];
            NSArray *weather = [json objectForKey:@"weather"];
            
            NSArray *desc = [[weather objectAtIndex:0] objectForKey:@"main"];
            
            item.title = [NSString stringWithFormat:@"%@ \n %@",name,desc];
            
            break;
        }
        case kCLAuthorizationStatusDenied:{
            statusItem.title = @"- °C";
            break;
        }
             kCLAuthorizationStatusNotDetermined:
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    [self update];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self update];

}


@end
