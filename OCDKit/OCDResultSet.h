//
//  OCDResultSet.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 1/29/14.
//  Copyright (c) 2014 Jeremy Carbaugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDResultSet : NSObject

@property (nonatomic, retain) NSArray* items;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, assign, readonly) NSInteger maxPage;
@property (nonatomic, assign, readonly) NSInteger page;
@property (nonatomic, assign, readonly) NSInteger perPage;
@property (nonatomic, assign, readonly) NSInteger totalCount;

@end
