//
//  OCDObject.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface OCDObject : MTLModel <MTLJSONSerializing>

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey;

@property (nonatomic, copy, readonly) NSString *ocdId; // Subclasses should map this to their id, if one exists
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSArray *sources; // OCDURL

@end
