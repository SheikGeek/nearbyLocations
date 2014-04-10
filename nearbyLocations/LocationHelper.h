//
//  LocatoionsAPIUtil.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define CLIENT_ID @"Z3TJBSZWVLLH4CQIZYEC4YSDPSFZJ0EV5M4RYJMWBFRQQO5S"
#define CLIENT_SECRET @"LL5SPVXAG3BHHJB2AS1BPDYFZT2KST0B1HWPMUZFKAYWHK0C"
#define bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface LocationHelper : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) NSArray *places;

- (void)getUserCurrentLocation;
- (CLLocationCoordinate2D)getUserCurrCoord;
- (void)queryForLocationsNearMe;

@end
