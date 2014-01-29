//
//  OCDClient.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDResultSet.h"

@interface OCDClient : NSObject

+ (id)clientWithKey:(NSString *)key;

- (OCDResultSet *)bills:(NSDictionary *)params;
- (OCDResultSet *)divisions:(NSDictionary *)params;
- (OCDResultSet *)events:(NSDictionary *)params;
- (OCDResultSet *)jurisdictions:(NSDictionary *)params;
- (OCDResultSet *)organizations:(NSDictionary *)params;
- (OCDResultSet *)people:(NSDictionary *)params;
- (OCDResultSet *)votes:(NSDictionary *)params;

@end
