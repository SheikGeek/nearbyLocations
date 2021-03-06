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
        
        NSString *imageFileName;
        if ([data[@"categories"][0][@"name"] rangeOfString:@"Caf"].location != NSNotFound) {
            imageFileName =[[NSBundle mainBundle] pathForResource:@"cafe" ofType:@"png"];

        }
        else {
        imageFileName =[[NSBundle mainBundle] pathForResource:[[data[@"categories"][0][@"name"] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"] ofType:@"png"];
            if (imageFileName == nil) {
                imageFileName =[[NSBundle mainBundle] pathForResource:@"restaurant" ofType:@"png"];
            }
        }
        
        UIImage *typeImage = [[UIImage alloc] initWithContentsOfFile:imageFileName];
    
        self.typeIcon.image  = typeImage;
        self.placeIcon.image = typeImage;
    }
    else {
        self.typeIcon.image = nil;
        self.type.text = @"";
        self.placeIcon.image = nil;
    }
    
}

@end
