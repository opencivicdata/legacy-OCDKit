//
//  OCDMediaReference.h
//  OCDKit
//
//  Created by Daniel Cloud on 4/18/14.
//
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface OCDMediaReference : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSDate   *date;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSArray  *links;
@property (nonatomic, copy, readonly) NSNumber *offset;

@end
