//
//  OCDPost.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"
#import "OCDOrganization.h"

@interface OCDPost : OCDObject

@property (nonatomic, copy, readonly) NSString *postId;
@property (nonatomic, copy, readonly) NSString *label;
@property (nonatomic, copy, readonly) NSString *role;
@property (nonatomic, copy, readonly) OCDOrganization *organization;

@property (nonatomic, copy, readonly) NSArray *contactDetails; // OCDContact
@property (nonatomic, copy, readonly) NSArray *links; // OCDLink

@property (nonatomic, copy, readonly) NSDate *startDate;
@property (nonatomic, copy, readonly) NSDate *endDate;

@end
