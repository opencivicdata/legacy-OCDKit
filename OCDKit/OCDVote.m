//
//  OCDVote.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDVote.h"

@implementation OCDVote

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":          @"id",
             @"organizationId": @"organization_id",
             @"voteCounts":     @"vote_counts",
             @"rollCall":       @"roll_call",
             };
}

+ (NSValueTransformer *)chamberJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
               @"upper": @(OCDChamberUpper),
               @"lower": @(OCDChamberLower),
               @"joint": @(OCDChamberJoint)
           }];
}

//+ (NSValueTransformer *)typeJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
//               @"passage": @(OCDVoteTypePassage),
//               @"amendment": @(OCDVoteTypeAmendment),
//               @"reading:2": @(OCDVoteTypeReading2),
//               @"reading:3": @(OCDVoteTypeReading3),
//               @"veto_override": @(OCDVoteTypeVetoOverride),
//               @"other": @(OCDVoteTypeVetoOther)
//           }];
//}

@end
