//
//  OCDObject.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

@implementation OCDObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at",
             @"sources": @"sources"
            };
}


@end
