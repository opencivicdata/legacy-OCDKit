//
//  OCDBillTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/25/14.
//
//

#import "OCDTestsBase.h"
#import "OCDBill.h"
#import "OCDName.h"
#import "OCDOrganization.h"
#import "OCDSession.h"
#import "OCDMediaReference.h"

@interface OCDBillTests : OCDTestsBase

@property (nonatomic, strong) id<OHHTTPStubsDescriptor> stub;
@property (nonatomic, strong) NSString *stubOCDId;

@end

//FIXME: Add stub for "complete" OCDBill object. Test multiple stub examples.
@implementation OCDBillTests

- (void)setUp
{
    [super setUp];
    self.stubOCDId = @"ocd-bill/0a660630-5385-11e3-b05f-1231391cd4ec";
    self.stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:[@"/" stringByAppendingString:self.stubOCDId]];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"ocd-bill--0a660630-5385-11e3-b05f-1231391cd4ec.json",nil)
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

- (void)tearDown
{
    [OHHTTPStubs removeStub:self.stub];
    [super tearDown];
}

- (void)testGetBill {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSURLSessionDataTask *task = [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);
}

- (void)testBillExpectedFields {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(self.stubOCDId);
    expect([blockResponseObject valueForKey:@"organizationId"]).will.equal(@"ocd-organization/c71f7344-3b46-11e3-9ac3-1231391cd4ec");
    expect([blockResponseObject valueForKey:@"chamber"]).will.equal(OCDChamberTypeUpper);
    expect([blockResponseObject valueForKey:@"title"]).will.equal(@"An Act establishing a sick leave bank for Cynthia (Bouchard) White, an employee of the Trial Court");
    expect([blockResponseObject valueForKey:@"type"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"subject"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"summaries"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"otherNames"]).will.beKindOf([NSArray class]);
}

- (void)testBillType {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"type"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([NSString class]);
            expect(obj).toNot.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"type"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"type"]).willNot.beEmpty(); // type actually can be empty
}

- (void)testBillSubject {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"subject"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([NSString class]);
            expect(obj).toNot.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"subject"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"subject"]).willNot.beEmpty(); // subject actually can be empty
}

- (void)testBillSummaries {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"summaries"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([NSDictionary class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKeyPath:@"note"]).toNot.beNil();
            expect([obj valueForKeyPath:@"note"]).to.beKindOf([NSString class]);
            expect([obj valueForKeyPath:@"text"]).toNot.beNil();
            expect([obj valueForKeyPath:@"text"]).to.beKindOf([NSString class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"summaries"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"summaries"]).willNot.beEmpty(); // summaries actually can be empty
}

- (void)testBillOtherTitles {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"otherTitles"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([NSDictionary class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKeyPath:@"note"]).toNot.beNil();
            expect([obj valueForKeyPath:@"note"]).to.beKindOf([NSString class]);
            expect([obj valueForKeyPath:@"title"]).toNot.beNil();
            expect([obj valueForKeyPath:@"title"]).to.beKindOf([NSString class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"otherTitles"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"otherTitles"]).willNot.beEmpty(); // otherTitles actually can be empty
}

- (void)testBillOtherNames {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"otherNames"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDName class]);
            expect(obj).toNot.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"otherNames"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"otherNames"]).willNot.beEmpty(); // otherTitles actually can be empty
}

- (void)testBillRelatedBills {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"relatedBills"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDBill class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKeyPath:@"name"]).toNot.beNil();
            expect([obj valueForKeyPath:@"name"]).to.beKindOf([NSString class]);
            expect([obj valueForKeyPath:@"session"]).toNot.beNil();
            expect([obj valueForKeyPath:@"session"]).to.beKindOf([NSString class]);
            expect([obj valueForKeyPath:@"relationType"]).toNot.beNil();
            expect([obj valueForKeyPath:@"relationType"]).to.beKindOf([NSString class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"relatedBills"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"relatedBills"]).willNot.beEmpty(); // otherTitles actually can be empty
}

- (void)testBillDocuments {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"documents"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDMediaReference class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKeyPath:@"offset"]).to.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"documents"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"documents"]).willNot.beEmpty(); // otherTitles actually can be empty
}

- (void)testBillVersions {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"versions"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            expect(obj).to.beInstanceOf([OCDMediaReference class]);
            expect(obj).toNot.beNil();
            XCTFail(@"Can't pass until we have some class for an OCDBillVersion");
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"versions"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"versions"]).willNot.beEmpty(); // otherTitles actually can be empty
}

@end
