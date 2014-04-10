//
//  nearbyLocationsTests.m
//  nearbyLocationsTests
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationHelper.h"

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

//The following tests sometimes are dependent upon the simultor being reset as the simulator
//will sometimes not keep Location Services set to on.
- (void)testGettingUsersLocation{
    LocationHelper *testHelper = [[LocationHelper alloc] init];
    [testHelper getUserCurrentLocation];
    
    //This is meant to be tested against simulator currently
    XCTAssertEqual([testHelper getUserCurrCoord].latitude, 37.785834, @"The user's latitude should be populated at this point");
    XCTAssertEqual([testHelper getUserCurrCoord].longitude, -122.406417, @"The user's longitude should be populated at this point");
}

- (void)testSettingUpAVenueCell {
    LocationHelper *testHelper = [[LocationHelper alloc] init];
    [testHelper getUserCurrentLocation];
    
    NSArray *testData = [[NSMutableArray alloc] init];
    testData = @[
                 @{ @"categories" : @{ @"icon" :
                                          @{ @"prefix" : @"https://ss1.4sqi.net/img/categories_v2/food/coffeeshop_", @"suffix" : @".png"
                                           },
                                      @"id" : @"4bf58dd8d48988d1e0931735",
                                      @"name" : @"Coffee Shop",
                                      @"pluralName" : @"Coffee Shops",
                                      @"primary" : @"1",
                                      @"shorName" : @"Coffee Shop"
                                    },
                    @"location" : @{ @"address" : @"780 Market St",
                                     @"cc" : @"US",
                                     @"city" : @"San Francisco",
                                     @"country" : @"United States",
                                     @"crossStreet" : @"4th St",
                                     @"distance" : @"96",
                                     @"lat" : @"37.78599020375594",
                                     @"lng" : @"-122.4053327491637",
                                     @"postalCode" : @"94102",
                                     @"state" : @"CA"
                                   },
                    @"name" : @"Starbucks"
                  }
                 ];
    
    testHelper.places = testData;
    
    //Check that we can access each value scope of value
    XCTAssertEqual(testHelper.places[0][@"categories"][@"name"], @"Coffee Shop", @"The Category name should be Coffee Shop, but is instead %@", testHelper.places[0][@"categories"][@"name"]);
    XCTAssertEqual(testHelper.places[0][@"location"][@"address"], @"780 Market St", @"The Location Address should be 780 Market St, but is instead %@", testHelper.places[0][@"location"][@"address"]);
    XCTAssertEqual(testHelper.places[0][@"name"], @"Starbucks", @"The Name of the Venue should be Starbucks, but is instead %@", testHelper.places[0][@"name"]);
}
@end
