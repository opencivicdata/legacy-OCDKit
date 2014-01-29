//
//  OCDSession.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

typedef enum : NSUInteger {
    OCDSessionTypePrimary,
    OCDSessionTypeSpecial
} OCDSessionType;

@interface OCDSession : OCDObject

@property (nonatomic, copy, readonly) NSDate *endDate;
@property (nonatomic, copy, readonly) NSDate *startDate;
@property (nonatomic, assign, readonly) NSUInteger *type;

@end
