//
//  OCDClient.h
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "OCDResultSet.h"

FOUNDATION_EXPORT NSString *const BASEURL;

@interface OCDClient : AFHTTPSessionManager

+ (id)clientWithKey:(NSString *)key;
+ (id)clientWithKey:(NSString *)key baseURL:(NSURL *)baseURL;

- (void)setKey:(NSString *)key;

- (void)bills:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (void)divisions:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (void)events:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (void)jurisdictions:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (void)organizations:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (void)people:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (void)votes:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;

@end
