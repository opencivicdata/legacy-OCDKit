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
    return [MTLValueTransformer transformerWithBlock:^id(NSDictionary *dictionary) {
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        NSValueTransformer *chamberTransformer = [OCDChamber typeJSONTransformer];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            obj = [MTLJSONAdapter modelOfClass:[OCDChamber class] fromJSONDictionary:obj error:nil];
            OCDChamberType chamberType = (OCDChamberType)[[chamberTransformer transformedValue:key] intValue];
            [newDict setObject:obj forKey:@(chamberType)];
        }];
        return [newDict copy];
    }];
}

+ (NSValueTransformer *)termsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDTerm.class];
}

@end
