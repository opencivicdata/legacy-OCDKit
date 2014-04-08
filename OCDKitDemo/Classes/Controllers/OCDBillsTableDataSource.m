//
//  OCDBillsTableDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDBillsTableDataSource.h"

@implementation OCDBillsTableDataSource

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDBill *bill = self.rows[indexPath.row];

    cell.textLabel.text = [bill.title capitalizedString];

    return cell;
}

@end
