//
//  OCDObject.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"
#import "OCDLink.h"

@implementation OCDObject

// Allows subclasses to automatically add keyPaths from OCDObject rather than
// doing the same override on JSONKeyPathsByPropertyKey each time
+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return nil;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *keyPaths =  @{
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at",
               @"sources": @"sources"
            };
    NSDictionary *additionalKeyPaths = [self ocd_JSONKeyPathsByPropertyKey];
    if (additionalKeyPaths) {
        keyPaths = [keyPaths mtl_dictionaryByAddingEntriesFromDictionary:additionalKeyPaths];
    }
    return keyPaths;
}

+ (ISO8601DateFormatter *)datetimeFormatter {
    static ISO8601DateFormatter *_datetimeFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _datetimeFormatter = [[ISO8601DateFormatter alloc] init];
        _datetimeFormatter.includeTime = YES;
        _datetimeFormatter.defaultTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    });

    return _datetimeFormatter;
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)sourcesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCDLink.class];
}

@end
