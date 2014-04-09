//
//  OCDVoteDataSource.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDVotesDataSource.h"

@implementation OCDVotesDataSource

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock {
    NSString *jurisdictionId = @"ocd-jurisdiction/country:us/state:me/legislature";
    OCDClient *client = [OCDClient clientWithKey:kSunlightAPIKey];

    __weak OCDVotesDataSource *weakSelf = self;
    [client votes:@{@"jurisdiction_id": jurisdictionId} completionBlock:^(OCDResultSet *results) {
        __strong OCDVotesDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    Override implamentation, duh.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OCDTableViewCell" forIndexPath:indexPath];

    OCDVote *object = self.rows[indexPath.row];

    cell.textLabel.text = [object.motion capitalizedString];
    cell.detailTextLabel.text = object.ocdId;

    return cell;
}

@end
