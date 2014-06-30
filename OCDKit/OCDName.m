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

+ (NSValueTransformer *)startDateJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)endDateJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

@end
