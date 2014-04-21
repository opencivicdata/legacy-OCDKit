//
//  OCDMediaReference.m
//  OCDKit
//
//  Created by Daniel Cloud on 4/18/14.
//
//

#import "OCDMediaReference.h"
#import "OCDLink.h"

@implementation OCDMediaReference

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{    @"date": @"date",
                 @"mediaType": @"type",
                 @"links": @"links",
                 @"offset": @"offset"
                 };
}

+ (NSValueTransformer *)linksJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

@end
