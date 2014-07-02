//
//  OCDJurisdiction.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"


typedef NS_ENUM(NSInteger, OCDJurisdictionClassification) {
    OCDJurisdictionClassificationUnknown,
    OCDJurisdictionClassificationGovernment,
    OCDJurisdictionClassificationLegislature,
    OCDJurisdictionClassificationExecutive,
    OCDJurisdictionClassificationSchool,
    OCDJurisdictionClassificationPark,
    OCDJurisdictionClassificationSewer,
    OCDJurisdictionClassificationForest,
    OCDJurisdictionClassificationTransit
};

@interface OCDJurisdiction : OCDObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, assign, readonly) OCDJurisdictionClassification classification;
@property (nonatomic, copy, readonly) NSString *divisionId;
@property (nonatomic, copy, readonly) NSArray *featureFlags;
@property (nonatomic, copy, readonly) NSArray *legislativeSessions;


@end
