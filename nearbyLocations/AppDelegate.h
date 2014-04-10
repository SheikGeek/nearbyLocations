//
//  AppDelegate.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) LocationHelper *location;

@end
