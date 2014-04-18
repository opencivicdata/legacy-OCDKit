//
//  OCDEvent.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

@interface OCDEvent : OCDObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *eventDescription;
@property (nonatomic, copy, readonly) NSDate *when;
@property (nonatomic, copy, readonly) NSDate *end;
@property (nonatomic, copy, readonly) NSDictionary *location;

@end
