//
//  OCDDivision.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

@interface OCDDivision : OCDObject

@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSArray *children;
@property (nonatomic, copy, readonly) NSArray *geometries;

@end
