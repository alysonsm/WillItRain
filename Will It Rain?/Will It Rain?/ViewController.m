//
//  ViewController.m
//  Will It Rain?
//
//  Created by Alyson Melo on 2012-10-16.
//  Copyright (c) 2012 Ikolu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize answer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create location manager object -
    locationManager = [[CLLocationManager alloc] init];
    // Make this instance of WhereamiAppDelegate the delegate // it will send its messages to our WhereamiAppDelegate
    [locationManager setDelegate:self];
    // We want all results from the location manager
    [locationManager setDistanceFilter:200];
    // And we want it to be as accurate as possible
    // regardless of how much time/power it takes
    [locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    // Tell our manager to start looking for its location immediately
    [locationManager startUpdatingLocation];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //Instanciando o novo objeto ja passando as coordenadas de newLocation.
    //O objeto tem um metodo pra pegas as cordenadas ja em string separada por virgula 
    user = [[UserWeatherLocation alloc] initWithCoordinate:newLocation];
    
    //Calling web service method
    [user runWebServicesCall];
    [self willItRain];
}


- (void)willItRain
{
    //Fix the comparation
    if (SUNNY_DAY != user.weatherCode){
        
        [answer setText:@"YES!"];
    }
    else{
        
        [answer setText:@"NO!"];
    }
}

@end
