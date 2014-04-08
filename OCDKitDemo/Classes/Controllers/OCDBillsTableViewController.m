//
//  OCDBillsTableViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDBillsTableViewController.h"
#import "OCDTableViewCell.h"

@interface OCDBillsTableViewController () <UITableViewDelegate>

@end

@implementation OCDBillsTableViewController

@synthesize billsSource;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.billsSource = [OCDBillsTableDataSource new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 100.0f;

    [self.tableView registerClass:OCDTableViewCell.class forCellReuseIdentifier:@"OCDTableViewCell"];
    self.tableView.dataSource = self.billsSource;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

@end
