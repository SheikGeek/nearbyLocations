//
//  Venue.m
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/5/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import "Venue.h"

@implementation Venue

-(void)setupData:(NSDictionary *) data {
    //Venue Name
    self.name.text = data[@"name"];
    
    //Distance of Venue from User
    NSDictionary *locationDist = data[@"location"];
    CGFloat distFloat =[locationDist[@"distance"] floatValue] * 0.000621371192;
    self.distanceFromUser.text = [NSString stringWithFormat:@"%.02f miles away", distFloat];
    
    //Venue Category w/ small icon
    if (data[@"categories"] != nil && [data[@"categories"] count] != 0) {
        self.type.text = data[@"categories"][0][@"name"];
        NSString *imageFileName =[[NSBundle mainBundle] pathForResource:[[data[@"categories"][0][@"name"] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"] ofType:@"png"];
        UIImage *typeImage = [[UIImage alloc] initWithContentsOfFile:imageFileName];
    
        self.typeIcon.image  = typeImage;
    }
    else {
        self.typeIcon = nil;
        self.type.text = @"";
    }
    
}

@end
