//
//  ViewController.m
//  nearbyLocations
//
//  Created by Chelsea Carr on 3/29/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@implementation MapViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;
    
    // Ensure that you can view your own location in the map view.
    [self.mapView setShowsUserLocation:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self plotPositions:appDelegate.location.places];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)refreshLocations:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Check that the User's current location and then replot the nearby locations on the map
    [appDelegate.location getUserCurrentLocation];
    [self plotPositions:appDelegate.location.places];
}

#pragma mark - MKMapViewDelegate methods.
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    MKCoordinateRegion region;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    region = MKCoordinateRegionMakeWithDistance([appDelegate.location getUserCurrCoord],1000,1000);
    [mv setRegion:region animated:YES];
    
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //Get the east and west points on the map so you can calculate the distance (zoom level) of the current map view.
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    currentDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    currentCentre = self.mapView.centerCoordinate;    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Define your reuse identifier.
    static NSString *identifier = @"MapPoint";

    if ([annotation isKindOfClass:[MapPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    return nil;
}

-(void)plotPositions:(NSArray *)data {
    //Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[MapPoint class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
      for (int i=0; i<[data count]; i++) {
        NSDictionary *currPlace = data[i];
        NSDictionary *loc = currPlace[@"location"];
        
        NSString *name= currPlace[@"name"];
        NSString *vicinity= loc[@"address"];

        // Set the lat and long.
        CLLocationCoordinate2D placeCoord;
        placeCoord.latitude= [loc[@"lat"] doubleValue];
        placeCoord.longitude= [loc[@"lng"] doubleValue];

        MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        [self.mapView addAnnotation:placeObject];
    }
}



@end
