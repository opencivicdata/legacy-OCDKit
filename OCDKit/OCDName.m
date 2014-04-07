//
//  OCDName.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDName.h"

@implementation OCDName

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
        @"startDate": @"start_date",
        @"endDate": @"end_date",
    };
}

@end
