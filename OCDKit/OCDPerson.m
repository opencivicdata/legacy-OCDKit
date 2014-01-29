//
//  OCDPerson.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDPerson.h"

@implementation OCDPerson

- (BOOL)isAlive {
    return self.deathDate != nil;
}

@end
