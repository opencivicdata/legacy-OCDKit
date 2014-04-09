//
//  OCDTableViewController.h
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCDSimpleDataSource.h"

@interface OCDTableViewController : UITableViewController

+ (instancetype)tableControllerWithDataSource:(id<OCDSimpleDataLoader,UITableViewDataSource>)source title:(NSString *)viewTitle imageNamed:(NSString *)imageName;

@property (nonatomic, strong) id <OCDSimpleDataLoader,UITableViewDataSource> dataController;

@end
