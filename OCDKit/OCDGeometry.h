//
//  OCDGeometry.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"
#import "OCDBoundary.h"

@interface OCDGeometry : OCDObject

@property (nonatomic, copy, readonly) NSDate *end;
@property (nonatomic, copy, readonly) NSDate *start;
@property (nonatomic, copy, readonly) OCDBoundary *boundary;

@end
