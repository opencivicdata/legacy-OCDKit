//
//  OCDEventsDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/18/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDEventsDataSource.h"

@implementation OCDEventsDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
//    NSString *jurisdictionId = @"ocd-jurisdiction/country:us/state:me/legislature";
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    __weak OCDEventsDataSource *weakSelf = self;
    [client events:@{@"when__gt": [NSDate date]} success:^(NSURLSessionDataTask *task, OCDResultSet *results) {
        __strong OCDEventsDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    Override implamentation, duh.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDEvent *object = self.rows[indexPath.row];

    NSString *label = object.eventDescription ?: object.name;

    cell.textLabel.text = [label capitalizedString];
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}

@end
