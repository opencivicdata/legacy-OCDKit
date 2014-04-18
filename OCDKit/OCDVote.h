//
//  OCDVote.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"
#import "OCDChamber.h"
#import "OCDBill.h"

typedef NS_ENUM(NSInteger, OCDVoteType){
    OCDVoteTypeNone,
    OCDVoteTypePassage,
    OCDVoteTypeAmendment,
    OCDVoteTypeReading2,
    OCDVoteTypeReading3,
    OCDVoteTypeVetoOverride,
    OCDVoteTypeVetoOther
};

typedef NS_ENUM(NSInteger, OCDVoteValue){
    OCDVoteValueUnknown,
    OCDVoteValueYes,
    OCDVoteValueNo,
    OCDVoteValueAbstain,
    OCDVoteValueNotVoting,
    OCDVoteValueOther,
};

@interface OCDVote : OCDObject

@property (nonatomic, copy, readonly) NSString *organizationId;
@property (nonatomic, copy, readonly) NSString *session;
@property (nonatomic, assign, readonly) OCDChamberType chamber;
@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *motion;
@property (nonatomic, copy, readonly) NSArray *type;
@property (nonatomic, assign, readonly) BOOL passed;
@property (nonatomic, copy, readonly) OCDBill *bill;
@property (nonatomic, copy, readonly) NSArray *voteCounts;
@property (nonatomic, copy, readonly) NSArray *rollCall;

@end
