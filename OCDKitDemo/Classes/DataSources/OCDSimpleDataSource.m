//
//  OCDSimpleDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDSimpleDataSource.h"

@implementation OCDSimpleDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rows = [NSArray array];
    }

    return self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.rows.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    Override implamentation, duh.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    cell.textLabel.text = @"OCD Object";

    return cell;
}

@end
