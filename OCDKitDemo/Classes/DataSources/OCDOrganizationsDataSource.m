//
//  OCDOrganizationsDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDOrganizationsDataSource.h"

@implementation OCDOrganizationsDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
    NSString *jurisdictionId = @"ocd-jurisdiction/country:us/state:me/legislature";
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    __weak OCDOrganizationsDataSource *weakSelf = self;
    [client organizations:@{@"jurisdiction_id": jurisdictionId} completionBlock:^(OCDResultSet *results) {
        __strong OCDOrganizationsDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDOrganization *object = self.rows[indexPath.row];

    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}

@end
