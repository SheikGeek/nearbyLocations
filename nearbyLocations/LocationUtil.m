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
    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"MyLocation:%@", locations);
    
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
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //Formulate the string as a URL object.
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
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    [self getOnlyNeededItemsOfFetchedData:[[json objectForKey:@"response"] objectForKey:@"venues"]];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", self.places);
    
    
};
- (void)getOnlyNeededItemsOfFetchedData:(NSArray *) data {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];

    for (int i=0; i<[data count]; i++) {
        NSDictionary *tempElementStorage;
        NSDictionary *currPlace = data[i];
        
        tempElementStorage = @{@"name" : currPlace[@"name"], @"location" : currPlace[@"location"], @"categories" : currPlace[@"categories"]};
        NSLog(@"%@", tempElementStorage);
        [tempArray addObject:tempElementStorage];
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
