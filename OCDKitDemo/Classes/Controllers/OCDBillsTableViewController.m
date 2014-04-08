//
//  OCDBillsTableViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDBillsTableViewController.h"

@implementation OCDBillsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.dataController = [OCDBillsTableDataSource new];
        self.title = @"Bills";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Bills" image:[UIImage imageNamed:@"Bill"] tag:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak OCDBillsTableViewController *weakSelf = self;
    [self.dataController loadDataWithCompletion:^(BOOL success) {
        __strong OCDBillsTableViewController *strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}

@end
