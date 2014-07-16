//
//  OCDDivisionTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/22/14.
//
//

#import "OCDTestsBase.h"
#import "OCDDivision.h"
#import "OCDGeometry.h"

NSString * const OCDRealDivisionId = @"ocd-division/country:us/district:dc";
NSString * const OCDRealDivisionPath = @"ocd-division-district-dc.json";

// Okay so SF is a real division, so maybe fake is not the right descriptor here.
NSString * const OCDFakeDivisionId = @"ocd-division/ocd-fake-division";
NSString * const OCDFakeDivisionPath = @"ocd-fake-division.json";

@interface OCDDivisionTests : OCDTestsBase

@property (nonatomic, weak) id<OHHTTPStubsDescriptor> stub;
@property (nonatomic, weak) id<OHHTTPStubsDescriptor> fakeDatastub;

@end

@implementation OCDDivisionTests

- (void)setUp {
    [super setUp];
    self.stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/ocd-division/country:us/district:dc"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"ocd-division-district-dc.json",nil)
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];

    self.fakeDatastub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        NSString *fakePath = [NSString stringWithFormat:@"/%@", OCDFakeDivisionId];
        return [request.URL.path isEqualToString:fakePath];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(OCDFakeDivisionPath,nil)
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

- (void)tearDown {
    [OHHTTPStubs removeStub:self.stub];
    [OHHTTPStubs removeStub:self.fakeDatastub];
    [super tearDown];
}

- (void)testGetDivision {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSURLSessionDataTask *task = [self.client divisionWithId:@"ocd-division/country:us/district:dc" fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

//  Check the task
    expect(task.state).will.equal(NSURLSessionTaskStateRunning);
    expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    expect(task.state).willNot.equal(NSURLSessionTaskStateCanceling);

//    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);
}

- (void)testFakeDivision {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client divisionWithId:OCDFakeDivisionId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        expect([responseObject valueForKey:@"geometries"]).to.beKindOf([NSArray class]);
        [[responseObject valueForKey:@"geometries"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDGeometry class]);
            OCDGeometry *geom = (OCDGeometry *)obj;
            expect(geom.start).to.beKindOf([NSDate class]);
            expect(geom.boundary).toNot.beNil();
            expect(geom.boundary.extent).toNot.beNil();
            expect(geom.boundary.extent).toNot.beEmpty();
        }];

        expect([responseObject valueForKey:@"children"]).to.beKindOf([NSArray class]);
        [[responseObject valueForKey:@"children"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDDivision class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);
}

- (void)testDivisionExpectedFields {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client divisionWithId:OCDRealDivisionId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);
    
    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(OCDRealDivisionId);
    expect([blockResponseObject valueForKey:@"country"]).will.equal(@"us");
    expect([blockResponseObject valueForKey:@"displayName"]).will.equal(@"District of Columbia");
}

- (void)testDivisionChildren {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSString *ocdId = @"ocd-division/country:us/district:dc";

    [self.client divisionWithId:ocdId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"children"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDDivision class]);
            expect([obj valueForKey:@"ocdId"]).notTo.beNil();
            expect([obj valueForKey:@"displayName"]).notTo.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);

    expect([blockResponseObject valueForKey:@"children"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"children"]).will.haveCountOf(102);
}

- (void)testDivisionGeometry {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSString *ocdId = @"ocd-division/country:us/district:dc";

    [self.client divisionWithId:ocdId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"geometries"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDGeometry class]);
            expect([obj valueForKey:@"start"]).notTo.beNil();
            expect([obj valueForKey:@"end"]).notTo.beNil();
            expect([obj valueForKey:@"boundary"]).to.beInstanceOf([OCDBoundary class]);;
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDDivision class]);

    expect([blockResponseObject valueForKey:@"geometries"]).will.beKindOf([NSArray class]);
}

@end
