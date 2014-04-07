//
//  MapPoint.m
//  nearbyLocations
//
//  Created by Chelsea Carr on 3/30/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

-(id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate  {
    if ((self = [super init])) {
        self.name = [name copy];
        self.address = [address copy];
        _coordinate = coordinate;
        
    }
    return self;
}

-(NSString *)title {
    return ([self.name isEqualToString:@""] || self.name == nil) ? @"Unknown charge" : self.name;
}

-(NSString *)subtitle {
    return self.address;
}

@end
