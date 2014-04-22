//
//  OCDPeopleDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDPeopleDataSource.h"

@implementation OCDPeopleDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    __weak OCDPeopleDataSource *weakSelf = self;
    [client people:@{} success:^(NSURLSessionDataTask *task, OCDResultSet *results) {
        __strong OCDPeopleDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDPerson *object = self.rows[indexPath.row];

    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}


@end
