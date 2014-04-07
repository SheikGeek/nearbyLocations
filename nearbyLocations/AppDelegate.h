//
//  AppDelegate.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationUtil.h"

#define bgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) LocationUtil *location;

@end
