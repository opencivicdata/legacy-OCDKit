//
//  OCDJurisdictionTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/24/14.
//
//

#import "OCDTestsBase.h"
#import "OCDJurisdiction.h"
#import "OCDChamber.h"
#import "OCDTerm.h"
#import "OCDSession.h"

NSString * const OCDRealJurisdictionId = @"ocd-jurisdiction/country:us/state:hi/legislature";
//NSString * const OCDRealJurisdictionPath = @".json";

NSString * const OCDFakeJurisdictionId = @"ocd-jurisdiction/conglomerate:ufp/government";
NSString * const OCDFakeJurisdictionPath = @"ocd-fake-jurisdiction.json";

@interface OCDJurisdictionTests : OCDTestsBase

@property (nonatomic, weak) id<OHHTTPStubsDescriptor> fakeJurisdictionStub;

@end

@implementation OCDJurisdictionTests

- (void)setUp
{
    [super setUp];
    self.fakeJurisdictionStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        NSString *urlPath = [NSString stringWithFormat:@"/%@", OCDFakeJurisdictionId];
        return [request.URL.path isEqualToString:urlPath];

    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *stubPath = OHPathForFileInBundle(OCDFakeJurisdictionPath,nil);
        return [OHHTTPStubsResponse responseWithFileAtPath:stubPath
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

- (void)tearDown
{
    [OHHTTPStubs removeStub:self.fakeJurisdictionStub];
    [super tearDown];
}

- (void)testGetJurisdiction {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSURLSessionDataTask *task = [self.client jurisdictionWithId:OCDRealJurisdictionId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);
}

- (void)testFakeJurisdiction {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client jurisdictionWithId:OCDFakeJurisdictionId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"legislativeSessions"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDSession class]);
            OCDSession *session = (OCDSession *)obj;
            expect(session.startDate).to.beKindOf([NSDate class]);
            expect(session.endDate).to.beKindOf([NSDate class]);
//            expect(session.name).toNot.beNil();

        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];


    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);


    // Check values
    OCDJurisdiction *obj = (OCDJurisdiction *)blockResponseObject;
    expect(obj.name).will.equal(@"United Federation of Planets");
    expect(obj.url).will.equal([NSURL URLWithString:@"http://en.memory-alpha.org/wiki/United_Federation_of_Planets"]);
    expect(obj.classification).willNot.beNil();
    expect(obj.classification).will.equal(OCDJurisdictionClassificationGovernment);
    expect(obj.divisionId).will.equal(@"ocd-division/conglomerate:ufp");
    expect(obj.featureFlags).will.beKindOf([NSArray class]);
    expect(obj.featureFlags).will.contain(@"interplanetary");
    expect(obj.legislativeSessions).willNot.beNil();
}

- (void)testJurisdictionExpectedFields {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client jurisdictionWithId:OCDRealJurisdictionId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);

    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(OCDRealJurisdictionId);
    expect([blockResponseObject valueForKey:@"url"]).will.beInstanceOf([NSURL class]);
    expect([blockResponseObject valueForKey:@"divisionId"]).willNot.beNil();
    expect([blockResponseObject valueForKey:@"featureFlags"]).willNot.beNil();
    expect([blockResponseObject valueForKey:@"legislativeSessions"]).willNot.beNil();
}


@end
