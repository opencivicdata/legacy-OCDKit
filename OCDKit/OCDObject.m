//
//  OCDObject.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

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


@end
