//
//  OCDOrganizationTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/25/14.
//
//

#import "OCDTestsBase.h"
#import "OCDOrganization.h"
#import "OCDIdentifier.h"
#import "OCDLink.h"
#import "OCDPost.h"
#import "OCDName.h"
#import "OCDContact.h"

@interface OCDOrganizationTests : OCDTestsBase

@property (nonatomic, strong) id<OHHTTPStubsDescriptor> stub;
@property (nonatomic, strong) NSString *stubOCDId;

@end

@implementation OCDOrganizationTests

- (void)setUp
{
    [super setUp];
    self.stubOCDId = @"ocd-organization/cc82145e-3b46-11e3-9ac3-1231391cd4ec";
    self.stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:[@"/" stringByAppendingString:self.stubOCDId]];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"ocd-organization--cc82145e-3b46-11e3-9ac3-1231391cd4ec.json",nil)
                                                statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
}

- (void)tearDown
{
    [OHHTTPStubs removeStub:self.stub];
    [super tearDown];
}

- (void)testGetOrganization {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSURLSessionDataTask *task = [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);
}

- (void)testOrganizationExpectedFields {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(self.stubOCDId);
    expect([blockResponseObject valueForKey:@"name"]).will.equal(@"Post Audit and Oversight");
    expect([blockResponseObject valueForKey:@"contactDetails"]).will.beInstanceOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"classification"]).will.equal(OCDOrganizationTypeCommittee);
    expect([blockResponseObject valueForKey:@"jurisdictionId"]).will.equal(@"ocd-jurisdiction/country:us/state:ma/legislature");
    expect([blockResponseObject valueForKey:@"foundingDate"]).will.beInstanceOf([NSDate class]);
    expect([blockResponseObject valueForKey:@"dissolutionDate"]).will.beInstanceOf([NSDate class]);
    expect([blockResponseObject valueForKey:@"links"]).will.beInstanceOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"posts"]).will.beInstanceOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"identifiers"]).will.beInstanceOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"otherNames"]).will.beInstanceOf([NSArray class]);
}

- (void)testOrganizationContactDetails {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"contactDetails"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDContact class]);
            expect([obj valueForKey:@"ocdId"]).notTo.beNil();
            expect([obj valueForKey:@"displayName"]).notTo.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"contactDetails"]).will.beInstanceOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"contactDetails"]).willNot.beEmpty(); // contactDetails actually can be empty
}

- (void)testOrganizationLinks {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"links"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDLink class]);
            expect([obj valueForKey:@"note"]).notTo.beNil();
            expect([obj valueForKey:@"url"]).notTo.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"links"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"links"]).willNot.beEmpty(); // links actually can be empty
}

- (void)testOrganizationPosts {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"posts"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDPost class]);
            expect([obj valueForKey:@"startDate"]).to.beInstanceOf([NSDate class]);
            expect([obj valueForKey:@"endDate"]).to.beInstanceOf([NSDate class]);
            expect([obj valueForKey:@"label"]).notTo.beNil();
            expect([obj valueForKey:@"role"]).notTo.beNil();
            expect([obj valueForKey:@"id"]).notTo.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"posts"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"posts"]).willNot.beEmpty(); // posts actually can be empty
}

- (void)testOrganizationIdentifiers {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"identifiers"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDIdentifier class]);
            expect([obj valueForKey:@"scheme"]).notTo.beNil();
            expect([obj valueForKey:@"identifier"]).notTo.beNil();
            expect([obj valueForKey:@"scheme"]).to.beKindOf([NSString class]);
            expect([obj valueForKey:@"identifier"]).to.beKindOf([NSString class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"identifiers"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"identifiers"]).willNot.beEmpty(); // posts actually can be empty
}

- (void)testOrganizationOtherNames {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"otherNames"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDName class]);
            expect([obj valueForKey:@"name"]).notTo.beNil();
            expect([obj valueForKey:@"note"]).notTo.beNil();
            expect([obj valueForKey:@"name"]).to.beKindOf([NSString class]);
            expect([obj valueForKey:@"note"]).to.beKindOf([NSString class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"otherNames"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"otherNames"]).willNot.beEmpty(); // otherNames actually can be empty
}

@end
