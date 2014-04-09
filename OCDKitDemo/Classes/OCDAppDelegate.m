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

@implementation OCDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [OCDStyle setUpAppearance];

    OCDTableViewController *billsVC         = [OCDTableViewController tableControllerWithDataSource:[OCDBillsTableDataSource new] title:@"Bills" imageNamed:@"Bill"];
    OCDTableViewController *organizationsVC = [OCDTableViewController tableControllerWithDataSource:[OCDOrganizationsDataSource new] title:@"Organizations" imageNamed:@"Organization"];
    OCDTableViewController *divisionsVC     = [OCDTableViewController tableControllerWithDataSource:[OCDDivisionsDataSource new] title:@"Divisions" imageNamed:@"Division"];
    OCDTableViewController *jurisdictionsVC = [OCDTableViewController tableControllerWithDataSource:[OCDJurisdictionsDataSource new] title:@"Jurisdictions" imageNamed:@"Jurisdiction"];

    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[billsVC, organizationsVC, divisionsVC, jurisdictionsVC];
    tabController.selectedViewController = billsVC;
    [self.window setRootViewController:tabController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    return YES;
}

@end
