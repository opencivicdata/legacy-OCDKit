//
//  OCDDivision.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDDivision.h"
#import "OCDGeometry.h"

@implementation OCDDivision

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":          @"id",
             @"displayName": @"display_name",
             };
}

+ (NSValueTransformer *)childrenJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDDivision.class];
}

+ (NSValueTransformer *)geometriesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDGeometry.class];
}

@end
