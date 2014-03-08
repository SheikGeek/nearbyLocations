//
//  DetailViewController.h
//  nearbyLocations
//
//  Created by Chelsea Carr on 3/8/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
