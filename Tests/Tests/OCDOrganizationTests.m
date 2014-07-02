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

NSString * const OCDRealOrgId = @"ocd-organization/cc82145e-3b46-11e3-9ac3-1231391cd4ec";
NSString * const OCDRealOrgPath = @"ocd-organization--cc82145e-3b46-11e3-9ac3-1231391cd4ec.json";

NSString * const OCDFakeOrgId = @"ocd-organization/cdba1034-b820-52a5-ab03-b311dd92875a";
NSString * const OCDFakeOrgPath = @"ocd-fake-organization.json";


@interface OCDOrganizationTests : OCDTestsBase

@property (nonatomic, weak) id<OHHTTPStubsDescriptor> stub;
@property (nonatomic, strong) NSString *stubOCDId;

@end

@implementation OCDOrganizationTests

- (void)setUp
{
    [super setUp];
    self.stubOCDId = OCDFakeOrgId;
    self.stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:[@"/" stringByAppendingString:self.stubOCDId]];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(OCDFakeOrgPath,nil)
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

- (void)testFakeOrganization {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;

        expect(responseObject).to.beInstanceOf([OCDOrganization class]);
        OCDOrganization *orgObject = (OCDOrganization *)responseObject;
        expect(orgObject.contactDetails).toNot.beEmpty();
        [orgObject.contactDetails enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDContact class]);
            if (idx == 0) {
                OCDContact *contactObj = (OCDContact *)obj;
                expect(contactObj.label).to.equal(@"Federation Council Building");
                expect(contactObj.type).toNot.beNil();
                expect(contactObj.type).to.beKindOf([NSString class]);
                expect(contactObj.value).toNot.beNil();
                expect(contactObj.value).to.beKindOf([NSString class]);
            }
        }];
        expect(orgObject.posts).toNot.beEmpty();
        [orgObject.posts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDPost class]);
            if (idx == 0) {
                OCDPost *post = (OCDPost *)obj;
                expect(post.postId).to.equal(@"ocd-organization/cdba1034-b820-52a5-ab03-b311dd92875a/federation-councilor");
                expect(post.contactDetails).toNot.beNil();
                expect(post.contactDetails).to.beKindOf([NSArray class]);
                expect(post.links).toNot.beNil();
                expect(post.links).to.beKindOf([NSArray class]);
                expect(post.label).toNot.beNil();
                expect(post.label).to.equal(@"Councilor");
            }
        }];
        expect(orgObject.links).toNot.beEmpty();
        [orgObject.links enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDLink class]);
            if (idx == 0) {
                OCDLink *link = (OCDLink *)obj;
                expect(link.url).toNot.beNil();
                expect(link.url).to.beKindOf([NSURL class]);
                expect([link.url absoluteString]).to.equal(@"http://en.memory-alpha.org/wiki/Federation_Council");
            }
        }];
        expect(orgObject.identifiers).toNot.beEmpty();
        [orgObject.identifiers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDIdentifier class]);
            if (idx == 0) {
                OCDIdentifier *identifier = (OCDIdentifier *)obj;
                expect(identifier.identifier).to.equal(@"UFP-FC");
                expect(identifier.scheme).notTo.beNil();
            }
        }];
        expect(orgObject.otherNames).toNot.beEmpty();
        [orgObject.otherNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDName class]);
            if (idx == 0) {
                OCDName *name = (OCDName *)obj;
                expect(name.name).toNot.beNil();
                expect(name.name).to.equal(@"Assembly of the Coalition of Planets");
                expect(name.note).to.equal(@"Provisional body of the immediate pre-Federation period.");
                expect(name.startDate).to.beKindOf([NSDate class]);
                expect(name.endDate).toNot.beNil();
            }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(self.stubOCDId);
    expect([blockResponseObject valueForKey:@"name"]).will.equal(@"Federation Council");
    expect([blockResponseObject valueForKey:@"classification"]).will.equal(OCDOrganizationTypeLegislature);
    expect([blockResponseObject valueForKey:@"jurisdictionId"]).will.equal(@"ocd-jurisdiction/conglomerate:ufp/planet:earth/legislature");
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

    expect([blockResponseObject valueForKey:@"contactDetails"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"foundingDate"]).will.beKindOf([NSDate class]);
//    expect([blockResponseObject valueForKey:@"dissolutionDate"]).will.beKindOf([NSDate class]); // can be nil
    expect([blockResponseObject valueForKey:@"links"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"posts"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"identifiers"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"otherNames"]).will.beKindOf([NSArray class]);
}

- (void)testOrganizationContactDetails {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client organizationWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"contactDetails"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDContact class]);
            expect([obj valueForKey:@"type"]).notTo.beNil();
            expect([obj valueForKey:@"value"]).notTo.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDOrganization class]);

    expect([blockResponseObject valueForKey:@"contactDetails"]).will.beKindOf([NSArray class]);
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
            OCDPost *postObject = (OCDPost *)obj;
            expect(postObject.startDate).to.beKindOf([NSDate class]);
            expect(postObject.startDate).toNot.beNil();
//            expect(postObject.endDate).to.beKindOf([NSDate class]); // Can't expect this to be not nil
            expect(postObject.label).notTo.beNil();
            expect(postObject.role).notTo.beNil();
            expect(postObject.postId).notTo.beNil();
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
