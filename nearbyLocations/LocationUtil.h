//
//  LocatoionsAPIUtil.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define GOOGLE_API_KEY @"AIzaSyCNtkj-JYaXDPnMPv_l72PaO1QCGTaj_h8"
#define bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface LocationUtil : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property(nonatomic, strong) NSArray *places;
@property(nonatomic, strong) NSCache *placesCache;

- (void)getUserCurrentLocation;
- (CLLocationCoordinate2D)getUserCurrCoord;
- (void)queryForLocationsNearMe;

@end
