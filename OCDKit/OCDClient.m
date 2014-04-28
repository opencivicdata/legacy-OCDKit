//
//  OCDClient.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDClient.h"
#import "ISO8601DateFormatter.h"
#import "OCDDivision.h"
#import "OCDJurisdiction.h"
#import "OCDOrganization.h"
#import "OCDPerson.h"
#import "OCDBill.h"
#import "OCDVote.h"
#import "OCDEvent.h"

NSString *const BASEURL = @"https://api.opencivicdata.org";

@interface OCDClient ()

- (OCDResultSet *)resultSetForResponse:(id)responseObject class:(Class)responseClass;
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                 resultsClass:(Class)responseClass
                      success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                      failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure;
@end

@implementation OCDClient

#pragma mark - init

+ (id)clientWithKey:(NSString *)key {
    return [OCDClient clientWithKey:key baseURL:[NSURL URLWithString:BASEURL]];
}

+ (id)clientWithKey:(NSString *)key baseURL:(NSURL *)baseURL {
    OCDClient *client = [[OCDClient alloc] initWithBaseURL:baseURL];
    [client setKey:key];
    return client;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];

        [self.requestSerializer setValue:@"OCDKit" forHTTPHeaderField:@"User-Agent"];
    };
    return self;
}

#pragma mark - OCDClient

- (void)setKey:(NSString *)key {
    [self.requestSerializer setValue:key forHTTPHeaderField:@"X-APIKEY"];
}

- (OCDResultSet *)resultSetForResponse:(id)responseObject class:(Class)responseClass {
    NSDictionary *metaDictionary = [responseObject valueForKeyPath:@"meta"];
    OCDResultSet *resultSet = [[OCDResultSet alloc] initWithCount:(NSInteger)[metaDictionary objectForKey:@"count"]
                                                             page:(NSInteger)[metaDictionary objectForKey:@"page"]
                                                          perPage:(NSInteger)[metaDictionary objectForKey:@"perPage"]
                                                          maxPage:(NSInteger)[metaDictionary objectForKey:@"maxPage"]
                                                       totalCount:(NSInteger)[metaDictionary objectForKey:@"totalCount"]];

    NSArray *results = [responseObject valueForKeyPath:@"results"];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:results.count];
    for (NSDictionary *jsonDict in results) {
        id obj = [MTLJSONAdapter modelOfClass:responseClass fromJSONDictionary:jsonDict error:NULL];
        [items addObject:obj];
    }
    resultSet.items = [NSArray arrayWithArray:items];
    return resultSet;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                 resultsClass:(Class)responseClass
                      success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                      failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    static ISO8601DateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[ISO8601DateFormatter alloc] init];
        _dateFormatter.includeTime = YES;
        _dateFormatter.defaultTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    });

    NSMutableDictionary *preEncodedParams = [[NSMutableDictionary alloc] initWithCapacity:parameters.count];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:NSDate.class]) {
            NSString *almostThere = [_dateFormatter stringFromDate:obj];
            obj = [almostThere substringToIndex:(almostThere.length-1)];
        }
        [preEncodedParams setObject:obj forKey:key];
    }];

    NSURLSessionDataTask *task = [self GET:URLString parameters:preEncodedParams success:^(NSURLSessionDataTask *task, id responseObject) {
        OCDResultSet *resultSet = [self resultSetForResponse:responseObject class:responseClass];
        success(task, resultSet);
    } failure:failure];

    return task;
}

#pragma mark - Object lookup methods

- (NSURLSessionDataTask *)objectWithId:(NSString *)ocdId fields:(NSArray *)fields class:(Class)responseClass
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    NSDictionary *params = @{};
    if (fields) {
        params = @{ @"fields": [fields componentsJoinedByString:@","] };
    }
    NSURLSessionDataTask *task = [self GET:ocdId parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        id obj = [MTLJSONAdapter modelOfClass:responseClass fromJSONDictionary:responseObject error:NULL];
        success(task, obj);
    } failure:failure];
    return task;
}

- (NSURLSessionDataTask *)billWithId:(NSString *)ocdId fields:(NSArray *)fields
                             success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self objectWithId:ocdId fields:fields class:OCDBill.class success:success failure:failure];
}

- (NSURLSessionDataTask *)divisionWithId:(NSString *)ocdId fields:(NSArray *)fields
                                 success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self objectWithId:ocdId fields:fields class:OCDDivision.class success:success failure:failure];
}

- (NSURLSessionDataTask *)eventWithId:(NSString *)ocdId fields:(NSArray *)fields
                              success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self objectWithId:ocdId fields:fields class:OCDEvent.class success:success failure:failure];
}

- (NSURLSessionDataTask *)jurisdictionWithId:(NSString *)ocdId fields:(NSArray *)fields
                                     success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                                     failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self objectWithId:ocdId fields:fields class:OCDJurisdiction.class success:success failure:failure];
}

- (NSURLSessionDataTask *)organizationWithId:(NSString *)ocdId fields:(NSArray *)fields
                                     success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                                     failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self objectWithId:ocdId fields:fields class:OCDOrganization.class success:success failure:failure];
}

- (NSURLSessionDataTask *)personWithId:(NSString *)ocdId fields:(NSArray *)fields
                               success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self objectWithId:ocdId fields:fields class:OCDPerson.class success:success failure:failure];
}

- (NSURLSessionDataTask *)voteWithId:(NSString *)ocdId fields:(NSArray *)fields
                             success:(void (^) (NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {
    return [self objectWithId:ocdId fields:fields class:OCDVote.class success:success failure:failure];
}

#pragma mark - Object search methods

- (NSURLSessionDataTask *)bills:(NSDictionary *)params
                        success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                           failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"bills/" parameters:params resultsClass:OCDBill.class success:success failure:failure];
}

- (NSURLSessionDataTask *)divisions:(NSDictionary *)params
                            success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"divisions/" parameters:params resultsClass:OCDDivision.class success:success failure:failure];
}

- (NSURLSessionDataTask *)events:(NSDictionary *)params
                         success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"events/" parameters:params resultsClass:OCDEvent.class success:success failure:failure];
}

- (NSURLSessionDataTask *)jurisdictions:(NSDictionary *)params
                                success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"jurisdictions/" parameters:params resultsClass:OCDJurisdiction.class success:success failure:failure];
}

- (NSURLSessionDataTask *)organizations:(NSDictionary *)params
                                success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"organizations/" parameters:params resultsClass:OCDOrganization.class success:success failure:failure];
}

- (NSURLSessionDataTask *)people:(NSDictionary *)params
                         success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"people/" parameters:params resultsClass:OCDPerson.class success:success failure:failure];
}

- (NSURLSessionDataTask *)votes:(NSDictionary *)params
                        success:(void (^) (NSURLSessionDataTask *task, OCDResultSet *results))success
                               failure:(void (^) (NSURLSessionDataTask *task, NSError *error))failure {

    return [self GET:@"votes/" parameters:params resultsClass:OCDVote.class success:success failure:failure];
}

@end
