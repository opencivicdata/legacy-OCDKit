//
//  OCDJurisdictionDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDJurisdictionsDataSource.h"

@implementation OCDJurisdictionsDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
    NSString *jurisdictionId = @"ocd-jurisdiction/country:us/state:me/legislature";
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    __weak OCDJurisdictionsDataSource *weakSelf = self;
    [client jurisdictions:@{@"jurisdiction_id": jurisdictionId} success:^(NSURLSessionDataTask *task, OCDResultSet *results) {
        __strong OCDJurisdictionsDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDJurisdiction *object = self.rows[indexPath.row];

    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}

@end
