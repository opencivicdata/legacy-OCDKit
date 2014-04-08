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
#import "OCDOrganizationsViewController.h"

@implementation OCDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [OCDStyle setUpAppearance];

    OCDBillsTableViewController *billsVC = [[OCDBillsTableViewController alloc] initWithStyle:UITableViewStylePlain];

    OCDOrganizationsViewController *organizationsVC = [[OCDOrganizationsViewController alloc] initWithStyle:UITableViewStylePlain];

    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[billsVC, organizationsVC];
    tabController.selectedViewController = billsVC;
    [self.window setRootViewController:tabController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    return YES;
}

@end
