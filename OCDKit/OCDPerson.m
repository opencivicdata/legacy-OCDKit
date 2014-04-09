//
//  OCDPerson.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDPerson.h"

@implementation OCDPerson

+ (NSDictionary *)ocd_JSONKeyPathsByPropertyKey {
    return @{
             @"ocdId":          @"id",
             @"contactDetails": @"contact_details",
             @"otherNames":     @"other_names",
             @"birthDate":   @"birth_date",
             @"deathDate":    @"death_date",
             };
}

- (BOOL)isAlive {
    return self.deathDate != nil;
}

@end
