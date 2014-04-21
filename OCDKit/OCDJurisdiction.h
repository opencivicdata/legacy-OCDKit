//
//  OCDJurisdiction.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

@interface OCDJurisdiction : OCDObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *abbreviation;
@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSDate *latestUpdate;
@property (nonatomic, copy, readonly) NSDictionary *chambers;
@property (nonatomic, copy, readonly) NSArray *terms;
@property (nonatomic, copy, readonly) NSDictionary *sessionDetails;


@end
