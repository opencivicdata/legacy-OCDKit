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
    [client bills:@{@"jurisdiction_id": jurisdictionId} completionBlock:^(OCDResultSet *results) {
        __strong OCDBillsTableDataSource *strongSelf = weakSelf;
        strongSelf.rows = results.items;
        completionBlock(YES);
    }];
}

@end
