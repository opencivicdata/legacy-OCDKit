//
//  OCDResultSet.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 1/29/14.
//  Copyright (c) 2014 Jeremy Carbaugh. All rights reserved.
//

#import "OCDResultSet.h"

@implementation OCDResultSet

@synthesize items = _items;
@synthesize count = _count;
@synthesize maxPage = _maxPage;
@synthesize page = _page;
@synthesize perPage = _perPage;
@synthesize totalCount = _totalCount;

- (id)initWithCount:(NSInteger)count
               page:(NSInteger)page
            perPage:(NSInteger)perPage
            maxPage:(NSInteger)maxPage
         totalCount:(NSInteger)totalCount
{
    self = [super init];
    if (self) {
        _count = count;
        _page = page;
        _perPage = perPage;
        _maxPage = maxPage;
        _totalCount = totalCount;
    }
    return self;
}

@end
