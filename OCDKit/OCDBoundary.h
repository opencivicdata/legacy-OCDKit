//
//  OCDBoundary.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

@interface OCDBoundary : OCDObject

@property (nonatomic, copy, readonly) NSDictionary *centroid;
@property (nonatomic, copy, readonly) NSArray *extent;

@end
