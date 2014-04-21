//
//  OCDLink.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface OCDLink : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *note;
@property (nonatomic, copy, readonly) NSString *mimetype;


@end
