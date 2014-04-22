//
//  OCDDivisionTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/22/14.
//
//

#import "OCDTestsBase.h"
#import "OCDDivision.h"

@interface OCDDivisionTests : OCDTestsBase

@end

@implementation OCDDivisionTests

- (void)setUp {
    [super setUp];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/ocd-division/country:us/district:dc"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"ocd-division-district-dc.json",nil)
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetDivision {
    __block id blockResponseObject = nil;

    NSURLSessionDataTask *task = [self.client divisionWithId:@"ocd-division/country:us/district:dc" fields:nil completionBlock:^(id responseObject) {
        blockResponseObject = responseObject;
    }];

//  Check the task
    expect(task.state).will.equal(NSURLSessionTaskStateRunning);
    expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    expect(task.state).willNot.equal(NSURLSessionTaskStateCanceling);

//    Check the response
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);
    expect([blockResponseObject valueForKeyPath:@"country"]).will.equal(@"us");
}

- (void)testGetDivisionCompleteness {
    __block id blockResponseObject = nil;

    NSString *ocdId = @"ocd-division/country:us/district:dc";

    NSURLSessionDataTask *task = [self.client divisionWithId:ocdId fields:nil completionBlock:^(id responseObject) {
        blockResponseObject = responseObject;
    }];

    //  Check the task
    expect(task.state).will.equal(NSURLSessionTaskStateRunning);
    expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    expect(task.state).willNot.equal(NSURLSessionTaskStateCanceling);

    //    Check the response
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);
    expect([blockResponseObject valueForKey:@"country"]).will.equal(@"us");
    expect([blockResponseObject valueForKey:@"displayName"]).will.equal(@"District of Columbia");
    expect([blockResponseObject valueForKey:@"children"]).will.haveCountOf(102);
}

@end
