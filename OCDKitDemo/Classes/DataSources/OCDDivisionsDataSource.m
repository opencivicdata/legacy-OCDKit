//
//  OCDDivisionsDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDDivisionsDataSource.h"

@implementation OCDDivisionsDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    NSDictionary *searchParams = @{@"lat": @(42.358056), @"lon": @(-71.063611)};

    __weak OCDDivisionsDataSource *weakSelf = self;
    [client divisions:searchParams completionBlock:^(OCDResultSet *results) {
        __strong OCDDivisionsDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDDivision *object = self.rows[indexPath.row];
//
    cell.textLabel.text = object.displayName;
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}

@end
