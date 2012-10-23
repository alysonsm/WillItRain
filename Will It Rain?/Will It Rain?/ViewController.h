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
    CLLocationManager * locationManager;
    UserWeatherLocation *user;
    
}

@property (weak, nonatomic) IBOutlet UILabel *answer;

- (void)willItRain;

@end
