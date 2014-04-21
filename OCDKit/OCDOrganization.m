//
//  OCDOrganization.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDOrganization.h"
#import "OCDIdentifier.h"
#import "OCDLink.h"
#import "OCDPost.h"
#import "OCDName.h"

@implementation OCDOrganization

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":           @"id",
             @"jurisdictionId":  @"jurisdiction_id",
             @"contactDetails":  @"contact_details",
             @"foundingDate":    @"founding_date",
             @"dissolutionDate": @"dissolution_date",
             @"otherNames":      @"other_names",
             };
}


+ (NSValueTransformer *)classificationJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
               NSNull.null: @(OCDOrganizationTypeUnknown),
               @"commission": @(OCDOrganizationTypeCommission),
               @"committee": @(OCDOrganizationTypeCommittee),
               @"legislature": @(OCDOrganizationTypeLegislature),
               @"party": @(OCDOrganizationTypeParty)
           }];
}

+ (NSValueTransformer *)identifiersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDIdentifier.class];
}

+ (NSValueTransformer *)linksJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

+ (NSValueTransformer *)postsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDPost.class];
}

+ (NSValueTransformer *)otherNamesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDName.class];
}

@end
