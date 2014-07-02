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

NSString * const OCDRealBillId = @"ocd-bill/0a660630-5385-11e3-b05f-1231391cd4ec";
NSString * const OCDRealBillPath = @"ocd-bill--0a660630-5385-11e3-b05f-1231391cd4ec.json";

NSString * const OCDFakeBillId = @"ocd-bill/this-is-a-fake-bill";
NSString * const OCDFakeBillPath = @"ocd-fake-bill.json";

@interface OCDBillTests : OCDTestsBase

@property (nonatomic, weak) id<OHHTTPStubsDescriptor> stub;
@property (nonatomic, strong) NSString *stubOCDId;

@end

//FIXME: Add stub for "complete" OCDBill object. Test multiple stub examples.
@implementation OCDBillTests

- (void)setUp
{
    [super setUp];
    self.stubOCDId = OCDFakeBillId;
    self.stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:self.client.baseURL.host];

    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *stubPath = OHPathForFileInBundle(OCDFakeBillPath,nil);
        return [OHHTTPStubsResponse responseWithFileAtPath:stubPath
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
    self.stub.name = @"Bill Stub";
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

- (void)testFakeBill {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"relatedBills"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDRelatedBill class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKey:@"session"]).to.equal(@"40278");
            expect([obj valueForKey:@"name"]).to.equal(@"FC 40278-771");
            expect([obj valueForKey:@"relationType"]).to.equal(OCDBillRelationTypeCompanion);
        }];
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

    // Our fake bill should have all optional values filled in
    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(@"ocd-bill/this-is-a-fake-bill");
    expect([blockResponseObject valueForKey:@"chamber"]).will.equal(OCDChamberTypeUpper);
    expect([blockResponseObject valueForKey:@"type"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"relatedBills"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"subject"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"summaries"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"otherTitles"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"otherNames"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"documents"]).willNot.beEmpty();
    expect([blockResponseObject valueForKey:@"versions"]).willNot.beEmpty();
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
}

- (void)testBillRelatedBills {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"relatedBills"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDRelatedBill class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKeyPath:@"name"]).toNot.beNil();
            expect([obj valueForKeyPath:@"name"]).to.beKindOf([NSString class]);
            expect([obj valueForKeyPath:@"session"]).toNot.beNil();
            expect([obj valueForKeyPath:@"session"]).to.beKindOf([NSString class]);
            expect([obj valueForKeyPath:@"relationType"]).toNot.beNil();
            expect([obj valueForKeyPath:@"relationType"]).to.to.beGreaterThanOrEqualTo(0);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"relatedBills"]).will.beKindOf([NSArray class]);
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
}

- (void)testBillVersions {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client billWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"versions"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDBillVersion class]);
            expect(obj).toNot.beNil();
            expect([obj valueForKeyPath:@"name"]).toNot.beNil();
            expect([obj valueForKeyPath:@"links"]).to.beKindOf([NSArray class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDBill class]);

    expect([blockResponseObject valueForKey:@"versions"]).will.beKindOf([NSArray class]);
}

@end
