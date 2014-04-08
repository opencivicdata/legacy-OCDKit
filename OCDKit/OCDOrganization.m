//
//  OCDOrganization.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDOrganization.h"

@implementation OCDOrganization

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":          @"id",
             @"jurisdictionId": @"orgjurisdiction_idanization_id",
             @"otherNames":     @"other_names",
             };
}


+ (NSValueTransformer *)classificationJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
               @"commission": @(OCDOrganizationTypeCommission),
               @"committee": @(OCDOrganizationTypeCommittee),
               @"legislature": @(OCDOrganizationTypeLegislature),
               @"party": @(OCDOrganizationTypeParty)
           }];
}

@end
