//
//  MasterViewController.m
//  nearbyLocations
//
//  Created by Chelsea Carr on 4/2/14.
//  Copyright (c) 2014 Chelsea Carr. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "Venue.h"

@implementation ListViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

-(IBAction)refreshLocations:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.location getUserCurrentLocation];
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.location.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Venue *venueCell = [tableView dequeueReusableCellWithIdentifier:@"Venue" forIndexPath:indexPath];

    if (venueCell == nil) {
        NSArray *cellBundle = [[NSBundle mainBundle] loadNibNamed:@"Venue" owner:self options:nil];
        venueCell = cellBundle[0];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [venueCell setupData:appDelegate.location.places[indexPath.row]];

    return venueCell;
}

@end
