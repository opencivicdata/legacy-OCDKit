//
//  OCDBillsTableViewController.h
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCDBillsTableDataSource.h"

@interface OCDBillsTableViewController : UITableViewController

@property (nonatomic, strong) OCDBillsTableDataSource *billsSource;

@end
