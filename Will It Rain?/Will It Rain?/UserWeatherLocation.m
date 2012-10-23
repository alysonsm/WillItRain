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


//WS

- (void)runWebServicesCall
{
    weatherCode = 0;
    xmlData = [[NSMutableData alloc] init];
    NSString *queryURLUnsafe = [NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?key=9e010a3ffd152736121710&q=%@", coordinates];
    NSString *queryURLsafe = [queryURLUnsafe stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString: queryURLsafe];
    /*
     NSURLRequest *req = [NSURLRequest requestWithURL:url];
     
     connection = [[NSURLConnection alloc] initWithRequest:req delegate: self startImmediately: YES];
     */
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    [xmlData appendData:data];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData: xmlData];
    [parser setDelegate: self];
    [parser parse];
    xmlData = nil;
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

@end
