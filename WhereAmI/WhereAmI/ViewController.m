//
//  ViewController.m
//  WhereAmI
//
//  Created by Alyson Melo on 2012-10-16.
//  Copyright (c) 2012 Ikolu. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    NSLog(@"Location %f %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
