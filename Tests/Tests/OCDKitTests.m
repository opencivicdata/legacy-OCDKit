//
//  OCDKitTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/22/14.
//
//

#import "OCDTestsBase.h"
#import <AFNetworking/AFURLConnectionOperation.h>

@interface OCDKitTests : OCDTestsBase

@end

@implementation OCDKitTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testClientURL {
    expect(self.client.baseURL.absoluteString).to.equal(@"https://api.opencivicdata.org");
}

- (void)testClientExpectsJSON {
    expect(self.client.responseSerializer).to.beKindOf([AFJSONResponseSerializer class]);
}

- (void)testClientWithBadKeyFails {
    [OHHTTPStubs setEnabled:NO];
    OCDClient *badClient = [OCDClient clientWithKey:@"foobar"];

    expect([badClient.requestSerializer.HTTPRequestHeaders valueForKey:@"X-APIKEY"]).to.equal(@"foobar");
    expect([badClient.requestSerializer.HTTPRequestHeaders valueForKey:@"User-Agent"]).to.equal(@"OCDKit");

    __block id blockResponseObject = nil;
    __block id blockError = nil;
    __block id blockErrorTask = nil;

    [badClient GET:@"ocd-division/country:us/district:dc/" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
        blockErrorTask = task;
    }];

    expect(blockError).willNot.beNil();
    expect([blockError domain]).will.equal(AFNetworkingErrorDomain);
    expect([blockError code]).will.equal(-1011);
    expect(blockErrorTask).willNot.beNil();
    expect(blockResponseObject).will.beNil();

    [OHHTTPStubs setEnabled:YES];
}

@end
