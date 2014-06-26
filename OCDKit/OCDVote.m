//
//  OCDVote.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDVote.h"
#import "OCDBill.h"

@implementation OCDVoteCount

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"count":    @"count",
             @"voteValue": @"vote_type",
             };
}

+ (NSValueTransformer *)voteValueJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
        NSNull.null: @(OCDVoteValueUnknown),
        @"yes": @(OCDVoteValueYes),
        @"no": @(OCDVoteValueNo),
        @"abstain": @(OCDVoteValueAbstain),
        @"not-voting": @(OCDVoteValueNotVoting),
        @"other": @(OCDVoteValueOther)
    }];
}

@end


@interface OCDVote ()

+ (NSValueTransformer *)voteTypeJSONTransformer;

@end

@implementation OCDVote

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":          @"id",
             @"organizationId": @"organization_id",
             @"voteCounts":     @"vote_counts",
             @"rollCall":       @"roll_call",
             };
}

#pragma mark - Internal transformer

+ (NSValueTransformer *)voteTypeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
        NSNull.null: @(OCDVoteTypeNone),
        @"passage": @(OCDVoteTypePassage),
        @"amendment": @(OCDVoteTypeAmendment),
        @"reading:2": @(OCDVoteTypeReading2),
        @"reading:3": @(OCDVoteTypeReading3),
        @"veto_override": @(OCDVoteTypeVetoOverride),
        @"other": @(OCDVoteTypeVetoOther)
        }];
}

#pragma mark - Public transformers

+ (NSValueTransformer *)chamberJSONTransformer {
    return [OCDChamber typeJSONTransformer];
}

+ (NSValueTransformer *)typeJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSArray *input) {
        NSMutableArray *output = [NSMutableArray arrayWithCapacity:input.count];
        NSValueTransformer *transformer = [self voteTypeJSONTransformer];
        [input enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id newVal = [transformer transformedValue:obj];
            [output insertObject:newVal atIndex:idx];
        }];
        return output;
    }];
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)billJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCDBill.class];
}

+ (NSValueTransformer *)voteCountsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDVoteCount.class];
}

@end
