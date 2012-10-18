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
    NSLog(@"Esse eh o teste do metodo de pegar as cordenadas: %@",[user coordinates]);
    
    //Calling web service method
    self.runWebServicesCall;
}

//WS

- (void)runWebServicesCall
{
    weatherCode = 0;
    xmlData = [[NSMutableData alloc] init];
    NSString *queryURLUnsafe = [NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?key=9e010a3ffd152736121710&q=%@", user.coordinates];
    NSString *queryURLsafe = [queryURLUnsafe stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString: queryURLsafe];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    connection = [[NSURLConnection alloc] initWithRequest:req delegate: self startImmediately: YES];
}

//Method Callback to append data into xmlData
- (void)connection: (NSURLConnection *)conn didReceiveData:(NSData *) data
{
    
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading: (NSURLConnection *)conn
{
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData: xmlData];
    [parser setDelegate: self];
    [parser parse];
    xmlData = nil;
    connection = nil;
}

//Reading XML File
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    weatherElement = elementName;
}

//Saving Element
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([weatherElement isEqual:@"weatherCode"]){
        
        NSLog(@"Getting element weather code: %@.", string);
        user.weatherCode = [string intValue];
        self.willItRain;
    }
}


- (void)connection: (NSURLConnection *)conn didFailWithError:(NSError *)error
{
    connection = nil;
    xmlData = nil;
    
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
    
    //Creating an alert
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message: errorString delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    
    [av show];
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
    NSLog(@"Answering question! Sunny day: %d and Weather Code %i.", SUNNY_DAY, user.weatherCode);
}

@end
