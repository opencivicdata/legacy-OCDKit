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

+ (instancetype)tableControllerWithDataSource:(id<OCDSimpleDataLoader,UITableViewDataSource>)source title:(NSString *)viewTitle imageNamed:(NSString *)imageName {
    OCDTableViewController *instance = [[OCDTableViewController alloc] initWithStyle:UITableViewStylePlain];
    if (instance) {
        instance.dataController = source;
        instance.title = viewTitle;
        instance.tabBarItem = [[UITabBarItem alloc] initWithTitle:viewTitle image:[UIImage imageNamed:imageName]  selectedImage:nil];
    }
    return instance;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 100.0f;

    [self.tableView registerClass:OCDTableViewCell.class forCellReuseIdentifier:@"OCDTableViewCell"];
    self.tableView.dataSource = self.dataController;
    self.tableView.delegate = self;

    __weak OCDTableViewController *weakSelf = self;
    [self.dataController loadDataWithCompletion:^(BOOL success) {
        __strong OCDTableViewController *strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}



@end
