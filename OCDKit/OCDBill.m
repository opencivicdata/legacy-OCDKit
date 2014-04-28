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
#import "OCDPerson.h"
#import "OCDMediaReference.h"

@implementation OCDBill

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
        @"ocdId":          @"id",
        @"organizationId": @"organization_id",
        @"otherNames":     @"other_names",
        @"otherTitles":    @"other_titles",
        @"relatedBills":   @"related_bills",
    };
}

+ (NSValueTransformer *)chamberJSONTransformer {
    return [OCDChamber typeJSONTransformer];
}

+ (NSValueTransformer *)otherNamesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OCDName class]];
}

+ (NSValueTransformer *)relatedBillsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OCDBill class]];
}

//TODO: Make a sponsorsJSONTransformer that can process an OCDPerson or OCDOrganization

//+ (NSValueTransformer *)sponsorsJSONTransformer {
//    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OCDPerson class]];
//}

+ (NSValueTransformer *)documentsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[OCDMediaReference class]];
}

@end
