//
//  OCDOrganization.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

typedef NS_ENUM(NSInteger, OCDOrganizationType) {
    OCDOrganizationTypeUnknown,
    OCDOrganizationTypeCommission,
    OCDOrganizationTypeCommittee,
    OCDOrganizationTypeLegislature,
    OCDOrganizationTypeParty
};

@interface OCDOrganization : OCDObject

@property (nonatomic, copy, readonly) NSString *jurisdictionId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) OCDOrganizationType classification;
//@property (nonatomic, copy, readonly) OCDOrganization *parent;
@property (nonatomic, copy, readonly) NSArray *contactDetails; // OCDContact
@property (nonatomic, copy, readonly) NSArray *links; // OCDURL
@property (nonatomic, copy, readonly) NSArray *posts; // OCDPost

@property (nonatomic, copy, readonly) NSDate *foundingDate;
@property (nonatomic, copy, readonly) NSDate *dissolutionDate;

@property (nonatomic, copy, readonly) NSArray *identifiers; // OCDIdentifier
@property (nonatomic, copy, readonly) NSArray *otherNames; // OCDName

@end
