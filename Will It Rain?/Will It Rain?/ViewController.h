//
//  ViewController.h
//  Will It Rain?
//
//  Created by Alyson Melo on 2012-10-16.
//  Copyright (c) 2012 Ikolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UserWeatherLocation.h"
#define SUNNY_DAY 113

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    int weatherCode;
    NSString *weatherElement;
    
    CLLocationManager * locationManager;
    UserWeatherLocation *user;
    
}

@property (weak, nonatomic) IBOutlet UILabel *answer;

- (void)runWebServicesCall;
- (void)willItRain;

@end
