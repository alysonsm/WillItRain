//
//  UserWeatherLocation.h
//  Will It Rain
//
//  Created by Igor Almeida on 2012-10-17.
//  Copyright (c) 2012 Ikolu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserWeatherLocation : NSObject{
  
}
@property (nonatomic, readonly) NSString *coordinates;
@property int weatherCode;

- (id) initWithCoordinate:(CLLocation *)c;


@end
