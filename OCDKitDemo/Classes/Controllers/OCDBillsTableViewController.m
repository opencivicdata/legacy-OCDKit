//
//  OCDBillsTableViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDBillsTableViewController.h"
#import "OCDBillTableViewCell.h"

@interface OCDBillsTableViewController ()

@end

@implementation OCDBillsTableViewController

@synthesize billsSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.billsSource = [OCDBillsTableDataSource new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:OCDBillTableViewCell.class forCellReuseIdentifier:@"OCDBillTableViewCell"];
    self.tableView.dataSource = self.billsSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
