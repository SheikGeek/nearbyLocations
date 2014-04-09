//
//  nearbyLocationsTests.m
//  nearbyLocationsTests
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationUtil.h"

@interface nearbyLocationsTests : XCTestCase

@end

@implementation nearbyLocationsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testQueryingForLocations {
    XCTAssertNil(nil, @"not nil");
}
@end
