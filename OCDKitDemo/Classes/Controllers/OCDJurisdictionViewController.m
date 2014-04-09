//
//  OCDJurisdictionViewController.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDJurisdictionViewController.h"
#import "OCDJurisdictionsDataSource.h"

@interface OCDJurisdictionViewController ()

@end

@implementation OCDJurisdictionViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.dataController = [OCDJurisdictionsDataSource new];
        self.title = @"Jurisdictions";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Jurisdictions" image:[UIImage imageNamed:@"Jurisdiction"] selectedImage:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak OCDJurisdictionViewController *weakSelf = self;
    [self.dataController loadDataWithCompletion:^(BOOL success) {
        __strong OCDJurisdictionViewController *strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}

@end
