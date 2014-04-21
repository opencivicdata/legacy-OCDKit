//
//  OCDPerson.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDPerson.h"
#import "OCDContact.h"
#import "OCDLink.h"
#import "OCDIdentifier.h"
#import "OCDName.h"

@implementation OCDPerson

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"sortName": @"sort_name",
             @"ocdId":          @"id",
             @"contactDetails": @"contact_details",
             @"otherNames":     @"other_names",
             @"birthDate":      @"birth_date",
             @"deathDate":      @"death_date",
             @"links":          @"links",
             };
}

- (BOOL)isAlive {
    return self.deathDate != nil;
}

+ (NSValueTransformer *)imageJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)contactDetailsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDIdentifier.class];
}

+ (NSValueTransformer *)linksJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

+ (NSValueTransformer *)identifiersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDIdentifier.class];
}

+ (NSValueTransformer *)otherNamesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDName.class];
}

+ (NSValueTransformer *)sourcesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

@end
