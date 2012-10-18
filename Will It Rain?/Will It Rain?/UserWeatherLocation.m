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

@end
