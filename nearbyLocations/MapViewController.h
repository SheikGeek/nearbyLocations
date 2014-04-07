//
//  ViewController.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 3/29/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapPoint.h"
#import "LocationUtil.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationCoordinate2D currentCentre;
    int currentDist;
}

@property(nonatomic, weak) IBOutlet MKMapView *mapView;

-(IBAction)refreshLocations:(id)sender;

@end
