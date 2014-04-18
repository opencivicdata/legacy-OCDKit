//
//  OCDEvent.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDEvent.h"
#import "OCDLink.h"
#import "OCDMediaReference.h"

@implementation OCDEvent

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":            @"id",
             @"eventDescription": @"description",
             @"links":            @"links",
             @"documents":        @"documents",
             @"media":            @"media",
             };
}

+ (NSValueTransformer *)whenJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)endJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)statusJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                NSNull.null: @(OCDEventStatusUnknown),
               @"tentative": @(OCDEventStatusTentative),
               @"confirmed": @(OCDEventStatusConfirmed),
               @"cancelled": @(OCDEventStatusCancelled),
                  @"passed": @(OCDEventStatusPassed)
           }];
}

+ (NSValueTransformer *)documentsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

+ (NSValueTransformer *)linksJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

+ (NSValueTransformer *)mediaJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDMediaReference.class];
}

@end
