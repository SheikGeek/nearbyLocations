//
//  Venue.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/5/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *name;
@property(nonatomic, weak) IBOutlet UILabel *distanceFromUser;
@property(nonatomic, weak) IBOutlet UILabel *type;
@property(nonatomic, weak) IBOutlet UIImageView *typeIcon;
@property(nonatomic, weak) IBOutlet UILabel *status;
@property(nonatomic, weak) IBOutlet UIImageView *placeIcon;

-(void)setupData:(NSDictionary *) data;

@end
