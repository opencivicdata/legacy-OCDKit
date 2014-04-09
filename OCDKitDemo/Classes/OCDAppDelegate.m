//
//  OCDAppDelegate.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/4/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDAppDelegate.h"
#import "OCDStyle.h"
#import "OCDBillsViewController.h"
#import "OCDOrganizationsViewController.h"
#import "OCDDivisionsViewController.h"
#import "OCDJurisdictionViewController.h"

@implementation OCDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [OCDStyle setUpAppearance];

    OCDBillsViewController *billsVC = [[OCDBillsViewController alloc] initWithStyle:UITableViewStylePlain];
    OCDOrganizationsViewController *organizationsVC = [[OCDOrganizationsViewController alloc] initWithStyle:UITableViewStylePlain];
    OCDDivisionsViewController *divisionsVC = [[OCDDivisionsViewController alloc] initWithStyle:UITableViewStylePlain];
    OCDJurisdictionViewController *jurisdictionsVC = [[OCDJurisdictionViewController alloc] initWithStyle:UITableViewStylePlain];

    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[billsVC, organizationsVC, divisionsVC, jurisdictionsVC];
    tabController.selectedViewController = billsVC;
    [self.window setRootViewController:tabController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    return YES;
}

@end
