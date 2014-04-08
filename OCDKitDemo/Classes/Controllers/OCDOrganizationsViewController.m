//
//  OCDOrganizationsViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDOrganizationsViewController.h"
#import "OCDOrganizationsDataSource.h"

@interface OCDOrganizationsViewController ()

@end

@implementation OCDOrganizationsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.dataController = [OCDOrganizationsDataSource new];
        self.title = @"Organizations";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Organizations" image:[UIImage imageNamed:@"Organization"] tag:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak OCDOrganizationsViewController *weakSelf = self;
    [self.dataController loadDataWithCompletion:^(BOOL success) {
        __strong OCDOrganizationsViewController *strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}

@end
