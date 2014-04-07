//
//  OCDClient.m
//  OCDKit
//
//  Created by Jeremy Carbaugh on 12/4/13.
//  Copyright (c) 2013 Jeremy Carbaugh. All rights reserved.
//

#import "OCDClient.h"
#import "OCDBill.h"

NSString *const BASEURL = @"https://api.opencivicdata.org";

@interface OCDClient ()

- (OCDResultSet *)resultSetForResponse:(id)responseObject class:(Class)responseClass;

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

#pragma mark - OCDClient API methods

- (void)bills:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    [self GET:@"bills/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        OCDResultSet *resultSet = [self resultSetForResponse:responseObject class:OCDBill.class];
        completionBlock(resultSet);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil);
    }];
}
- (void)divisions:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    //
}
- (void)events:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    //
}
- (void)jurisdictions:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    //
}
- (void)organizations:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    //
}
- (void)people:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    //
}
- (void)votes:(NSDictionary *)params completionBlock:(void (^)(OCDResultSet *results))completionBlock {
    //
}

@end
