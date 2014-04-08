//
//  OCDAppDelegate.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/4/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDAppDelegate.h"
#import "OCDStyle.h"
#import "OCDBillsTableViewController.h"

@implementation OCDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [OCDStyle setUpAppearance];

    NSString *jurisdictionId = @"ocd-jurisdiction/country:us/state:me/legislature";
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    OCDBillsTableViewController *billsVC = [[OCDBillsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    billsVC.title = @"Bills";

    __weak OCDBillsTableViewController *weakBillsVC = billsVC;
    [client bills:@{@"jurisdiction_id": jurisdictionId} completionBlock:^(OCDResultSet *results) {
        __strong OCDBillsTableViewController *strongBillsVC = weakBillsVC;
        strongBillsVC.billsSource.rows = results.items;
        [strongBillsVC.tableView reloadData];
    }];


    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[billsVC];
    [self.window setRootViewController:tabController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    return YES;
}

@end
