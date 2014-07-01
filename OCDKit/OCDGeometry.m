//
//  OCDGeometry.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDGeometry.h"

@implementation OCDGeometry

+ (NSValueTransformer *)startJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)endJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^id(NSString *str) {
        return [[self datetimeFormatter] dateFromString:str];
    }];
}

+ (NSValueTransformer *)boundaryJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OCDBoundary class]];
}

@end
