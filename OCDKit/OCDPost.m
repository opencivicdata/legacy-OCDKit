//
//  OCDPost.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDPost.h"
#import "OCDContact.h"
#import "OCDLink.h"

@implementation OCDPost

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"postId":         @"id",
             @"contactDetails": @"contact_details",
             @"links":          @"links",
             @"startDate":      @"start_date",
             @"endDate":        @"end_date",
             };
}

+ (NSValueTransformer *)contactDetailsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDContact.class];
}

+ (NSValueTransformer *)linksDetailsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

@end
