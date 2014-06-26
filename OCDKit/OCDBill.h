//
//  OCDBill.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"
#import "OCDOrganization.h"
#import "OCDSession.h"
#import "OCDChamber.h"


typedef NS_ENUM(NSInteger, OCDBillRelationType) {
    OCDBillRelationTypeUnknown,
    OCDBillRelationTypeCompanion
};

@interface OCDBillVersion : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSArray *links;

@end

@interface OCDRelatedBill : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSDate *session;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) OCDBillRelationType relationType;

@end

@interface OCDBill : OCDObject

@property (nonatomic, copy, readonly) NSString *organizationId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) OCDChamberType chamber;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *session;
@property (nonatomic, copy, readonly) NSArray *type;
@property (nonatomic, copy, readonly) NSArray *subject;
@property (nonatomic, copy, readonly) NSArray *summaries; // ???: (note, text)
@property (nonatomic, copy, readonly) NSArray *otherTitles; // (note, title)
@property (nonatomic, copy, readonly) NSArray *otherNames; // OCDName
@property (nonatomic, copy, readonly) NSArray *relatedBills; // (session, name, relation_type:companion)
@property (nonatomic, copy, readonly) NSArray *sponsors; // OCDPerson or OCDOrganization
@property (nonatomic, copy, readonly) NSArray *documents; // OCDMediaReference
@property (nonatomic, copy, readonly) NSArray *versions; // OCDBillVersion: (date, type, name, links)

@end
