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

- (NSURLSessionDataTask *)objectWithId:(NSString *)ocdId fields:(NSArray *)fields class:(Class)responseClass
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)billWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)divisionWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)eventWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)jurisdictionWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)organizationWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)personWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)voteWithId:(NSString *)ocdId fields:(NSArray *)fields
                             success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)bills:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)divisions:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)events:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)jurisdictions:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)organizations:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)people:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)votes:(NSDictionary *)params
                               success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;

@end
