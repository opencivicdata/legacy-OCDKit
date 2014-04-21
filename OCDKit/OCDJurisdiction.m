//
//  OCDJurisdiction.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDJurisdiction.h"
#import "OCDChamber.h"
#import "OCDTerm.h"

@implementation OCDJurisdiction

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":          @"id",
             @"latestUpdate":   @"latest_update",
             @"sessionDetails": @"session_details"
             };
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)chambersJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCDChamber.class];
}

+ (NSValueTransformer *)termsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDTerm.class];
}

@end
