//
//  UserWeatherLocation.m
//  Will It Rain
//
//  Created by Igor Almeida on 2012-10-17.
//  Copyright (c) 2012 Ikolu. All rights reserved.
//

#import "UserWeatherLocation.h"

@implementation UserWeatherLocation
@synthesize coordinates, weatherCode;

- (id) initWithCoordinate:(CLLocation *)c
{
    self = [super init];
    if (self)
    {
        coordinates = [NSString stringWithFormat:@"%f,%f", c.coordinate.latitude, c.coordinate.longitude];
    }
        
    return self;
}


- (void) runWebServicesCall
{
    weatherCode = 0;
    xmlData = [[NSMutableData alloc] init];
    NSString *queryURLUnsafe = [NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?key=9e010a3ffd152736121710&q=%@", coordinates];
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
        weatherCode = [string intValue];       
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

- (Boolean)willItRain
{
    return (SUNNY_DAY ==  weatherCode);
}
@end
