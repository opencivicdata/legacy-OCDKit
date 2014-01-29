//
//  OCDPerson.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDObject.h"

@interface OCDPerson : OCDObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *sortName;
@property (nonatomic, copy, readonly) NSURL *image;
@property (nonatomic, copy, readonly) NSArray *contactDetails; // OCDContact
@property (nonatomic, copy, readonly) NSArray *links; // OCDURL
@property (nonatomic, copy, readonly) NSArray *identifiers; // OCDIdentifier
@property (nonatomic, copy, readonly) NSArray *otherNames; // OCDName

@property (nonatomic, copy, readonly) NSString *gender;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *biography;

@property (nonatomic, copy, readonly) NSDate *birthDate;
@property (nonatomic, copy, readonly) NSDate *deathDate;

- (BOOL)isAlive;

@end
