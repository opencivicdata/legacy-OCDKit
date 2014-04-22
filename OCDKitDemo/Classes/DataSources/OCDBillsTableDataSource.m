//
//  OCDBillsTableDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDBillsTableDataSource.h"

@implementation OCDBillsTableDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
    NSString *jurisdictionId = @"ocd-jurisdiction/country:us/state:me/legislature";
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    __weak OCDBillsTableDataSource *weakSelf = self;
    [client bills:@{@"jurisdiction_id": jurisdictionId} success:^(NSURLSessionDataTask *task, OCDResultSet *results) {
        __strong OCDBillsTableDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    Override implamentation, duh.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDBill *object = self.rows[indexPath.row];

    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}

@end
