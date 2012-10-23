//
//  UserWeatherLocation.h
//  Will It Rain
//
//  Created by Igor Almeida on 2012-10-17.
//  Copyright (c) 2012 Ikolu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#define SUNNY_DAY 113

@interface UserWeatherLocation : NSObject{
    
    NSURLConnection *connection;
    NSMutableData *xmlData;
    int weatherCode;
    NSString *weatherElement;
}
@property (nonatomic, readonly) NSString *coordinates;
@property int weatherCode;

- (id) initWithCoordinate:(CLLocation *)c;
- (void)runWebServicesCall;

@end
