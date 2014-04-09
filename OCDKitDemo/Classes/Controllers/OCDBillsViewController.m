//
//  OCDBillsTableViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDBillsViewController.h"

@implementation OCDBillsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.dataController = [OCDBillsTableDataSource new];
        self.title = @"Bills";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Bills" image:[UIImage imageNamed:@"Bill"]  selectedImage:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak OCDBillsViewController *weakSelf = self;
    [self.dataController loadDataWithCompletion:^(BOOL success) {
        __strong OCDBillsViewController *strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}

@end
