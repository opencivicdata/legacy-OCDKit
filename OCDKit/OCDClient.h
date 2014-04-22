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

- (NSURLSessionDataTask *)objectWithId:(NSString *)ocdId fields:(NSArray *)fields class:(Class)responseClass completionBlock:(void (^)(id responseObject))completionBlock;
- (NSURLSessionDataTask *)billWithId:(NSString *)ocdId fields:(NSArray *)fields completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)divisionWithId:(NSString *)ocdId fields:(NSArray *)fields completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)eventWithId:(NSString *)ocdId fields:(NSArray *)fields completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)jurisdictionWithId:(NSString *)ocdId fields:(NSArray *)fields completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)organizationWithId:(NSString *)ocdId fields:(NSArray *)fields completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)personWithId:(NSString *)ocdId fields:(NSArray *)fields completionBlock:(void (^)(OCDResultSet *results))completionBlock;

- (NSURLSessionDataTask *)bills:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)divisions:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)events:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)jurisdictions:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)organizations:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)people:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;
- (NSURLSessionDataTask *)votes:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock;

@end
