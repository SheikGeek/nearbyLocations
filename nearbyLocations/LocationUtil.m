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
    // Build the url string to send to Google. NOTE: The kGOOGLE_API_KEY is a constant that should contain your own API key that you obtain from Google. See this link for more info:
    // https://developers.google.com/maps/documentation/places/#Authentication
    NSString *url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f, %f&radius=500&query=coffee&client_id=Z3TJBSZWVLLH4CQIZYEC4YSDPSFZJ0EV5M4RYJMWBFRQQO5S&client_secret=LL5SPVXAG3BHHJB2AS1BPDYFZT2KST0B1HWPMUZFKAYWHK0C&v=20131016", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];//[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", currLoc.latitude, currLoc.longitude, [NSString stringWithFormat:@"%i", dist], googleType, GOOGLE_API_KEY];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(bgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    //self.places = [[json objectForKey:@"response"] objectForKey:@"venues"];
    [self getOnlyNeededItemsOfFetchedData:[[json objectForKey:@"response"] objectForKey:@"venues"]];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", self.places);
    
    //TODO set up NSCache
    //[self plotPositions:places];
    
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
