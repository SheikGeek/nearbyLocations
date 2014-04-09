//
//  LocatoionsAPIUtil.m
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import "LocationUtil.h"

@implementation LocationUtil

- (void)getUserCurrentLocation {
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"User's Location:%@", locations);
    
    [locationManager stopUpdatingLocation];
    [self queryForLocationsNearMe];
}

- (CLLocationCoordinate2D)getUserCurrCoord {
    return locationManager.location.coordinate;
}

#pragma mark - googleQuery methods
-(void) queryForLocationsNearMe {

    //https://developer.foursquare.com/docs/venues/search
    NSString *url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f, %f&radius=500&query=coffee&client_id=%@&client_secret=%@&v=20131016", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude, CLIENT_ID, CLIENT_SECRET];
    
    //In case characters (such as spaces) are passed back
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *requestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(bgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:requestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedData:(NSData *)responseData {
    if (responseData == nil) {
        UIAlertView *alert;
        if (self.places == nil) {
            alert = [[UIAlertView alloc] initWithTitle:@"Network Issue" message:@"Your nearby locations could not be gathered at this time. Please check your internet connection and try again later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        }
        else {
            alert = [[UIAlertView alloc] initWithTitle:@"Network Issue" message:@"Your nearby locations could not be refreshed. Please check your internet connection and try again later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        }
        [alert show];
        return;
    }
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    [self getOnlyNeededItemsOfFetchedData:json[@"response"][@"venues"]];
    
    //Write out the data to the console.
    NSLog(@"Foursquare Data: %@", self.places);
}

- (void)getOnlyNeededItemsOfFetchedData:(NSArray *) data {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];

    for (int i=0; i<[data count]; i++) {
        NSDictionary *tempElementStorage;
        NSDictionary *currPlace = data[i];
        
        //only keep the data we are currently going to use.
        tempElementStorage = @{@"name" : currPlace[@"name"], @"location" : currPlace[@"location"], @"categories" : currPlace[@"categories"]};
        tempArray[i] = tempElementStorage;

        NSLog(@"Item %i to be stored in an array %@", i, tempElementStorage);
    }
    [self sortFetchedData:tempArray];
}

- (void)sortFetchedData:(NSArray *) tempArray {
    self.places = [tempArray sortedArrayUsingComparator:^(NSDictionary *a, NSDictionary *b){
        if ([a[@"location"][@"distance"] floatValue] > [b[@"location"][@"distance"] floatValue])
            return NSOrderedDescending;
        else if ([a[@"location"][@"distance"] floatValue] < [b[@"location"][@"distance"] floatValue])
            return NSOrderedAscending;
        return NSOrderedSame;
    }];
}
                                            
@end
