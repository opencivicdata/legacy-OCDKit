//
//  OCDBill.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDBill.h"
#import "OCDName.h"
#import "OCDOrganization.h"
#import "OCDSession.h"

@implementation OCDBill

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"otherNames": @"other_names",
        @"otherTitles": @"other_titles",
        @"relatedBills": @"related_bills",
        @"updatedAt": @"updated_at",
        @"createdAt": @"created_at",
    };
}

+ (NSValueTransformer *)organizationJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OCDOrganization class]];
}

+ (NSValueTransformer *)sessionJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OCDSession class]];
}

+ (NSValueTransformer *)otherNamesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OCDName class]];
}

+ (NSValueTransformer *)typesJSONTransformer {
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
