//
//  OCDAppDelegate.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/4/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDAppDelegate.h"
#import "OCDStyle.h"
#import "OCDTableViewController.h"
#import "OCDBillsTableDataSource.h"
#import "OCDOrganizationsDataSource.h"
#import "OCDDivisionsDataSource.h"
#import "OCDJurisdictionsDataSource.h"
#import "OCDPeopleDataSource.h"
#import "OCDVotesDataSource.h"
#import "OCDEventsDataSource.h"

@implementation OCDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [OCDStyle setUpAppearance];

    OCDTableViewController *billsVC         = [OCDTableViewController tableControllerWithDataSource:[OCDBillsTableDataSource new] title:@"Bills" imageNamed:@"Bill"];
    OCDTableViewController *organizationsVC = [OCDTableViewController tableControllerWithDataSource:[OCDOrganizationsDataSource new] title:@"Organizations" imageNamed:@"Organization"];
    OCDTableViewController *divisionsVC     = [OCDTableViewController tableControllerWithDataSource:[OCDDivisionsDataSource new] title:@"Divisions" imageNamed:@"Division"];
    OCDTableViewController *jurisdictionsVC = [OCDTableViewController tableControllerWithDataSource:[OCDJurisdictionsDataSource new] title:@"Jurisdictions" imageNamed:@"Jurisdiction"];
    OCDTableViewController *peopleVC         = [OCDTableViewController tableControllerWithDataSource:[OCDPeopleDataSource new] title:@"People" imageNamed:@"Person"];
    OCDTableViewController *votesVC         = [OCDTableViewController tableControllerWithDataSource:[OCDVotesDataSource new] title:@"Votes" imageNamed:@"Vote"];
    OCDTableViewController *eventsVC         = [OCDTableViewController tableControllerWithDataSource:[OCDEventsDataSource new] title:@"Events" imageNamed:@"Event"];

    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[billsVC, organizationsVC, divisionsVC, jurisdictionsVC, peopleVC, votesVC, eventsVC];
    tabController.selectedViewController = billsVC;
    [self.window setRootViewController:tabController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    return YES;
}

@end
