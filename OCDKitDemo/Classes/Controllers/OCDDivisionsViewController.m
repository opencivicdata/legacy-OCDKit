//
//  OCDDivisionsViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDDivisionsViewController.h"
#import "OCDDivisionsDataSource.h"

@interface OCDDivisionsViewController ()

@end

@implementation OCDDivisionsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.dataController = [OCDDivisionsDataSource new];
        self.title = @"Divisions";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Divisions" image:[UIImage imageNamed:@"Division"]  selectedImage:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak OCDDivisionsViewController *weakSelf = self;
    [self.dataController loadDataWithCompletion:^(BOOL success) {
        __strong OCDDivisionsViewController *strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}


@end
