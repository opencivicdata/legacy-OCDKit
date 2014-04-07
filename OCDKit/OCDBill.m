//
//  OCDBill.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "OCDBill.h"
#import "OCDName.h"
#import "OCDOrganization.h"
#import "OCDSession.h"

@implementation OCDBill

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
        @"ocdId":   @"id",
        @"organizationId": @"organization_id",
        @"otherNames":   @"other_names",
        @"otherTitles":  @"other_titles",
        @"relatedBills": @"related_bills",
    };
}

//+ (NSValueTransformer *)organizationJSONTransformer {
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OCDOrganization class]];
//}
//
//+ (NSValueTransformer *)sessionJSONTransformer {
//    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OCDSession class]];
//}

+ (NSValueTransformer *)otherNamesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OCDName class]];
}

+ (NSValueTransformer *)typeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id idArr) {
        return idArr;
    }];
}

+ (NSValueTransformer *)subjectsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id idArr) {
        return idArr;
    }];
}

@end
