//
//  OCDTableViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDTableViewController.h"
#import "OCDTableViewCell.h"

@interface OCDTableViewController () <UITableViewDelegate>

@end

@implementation OCDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 100.0f;

    [self.tableView registerClass:OCDTableViewCell.class forCellReuseIdentifier:@"OCDTableViewCell"];
    self.tableView.dataSource = self.dataController;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}


@end
