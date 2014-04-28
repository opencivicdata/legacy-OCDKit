//
//  OCDChamber.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDChamber.h"

@implementation OCDChamber

+ (NSValueTransformer *)typeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
               NSNull.null: @(OCDChamberTypeUnknown),
               @"upper":    @(OCDChamberTypeUpper),
               @"lower":    @(OCDChamberTypeLower),
               @"joint":    @(OCDChamberTypeJoint),
           }];
}


@end
