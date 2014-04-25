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

@interface OCDJurisdictionTests : OCDTestsBase

@end

@implementation OCDJurisdictionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetJurisdiction {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSURLSessionDataTask *task = [self.client jurisdictionWithId:@"ocd-jurisdiction/country:us/state:hi/legislature" fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)testJurisdictionExpectedFields {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSString *ocdId = @"ocd-jurisdiction/country:us/state:hi/legislature";

    [self.client jurisdictionWithId:ocdId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);

    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(ocdId);
    expect([blockResponseObject valueForKey:@"name"]).will.equal(@"Hawaii State Legislature");
    expect([blockResponseObject valueForKey:@"abbreviation"]).will.equal(@"hi");
    expect([blockResponseObject valueForKey:@"url"]).will.equal([NSURL URLWithString:@"http://www.capitol.hawaii.gov/"]);
    expect([blockResponseObject valueForKey:@"latestUpdate"]).will.beInstanceOf([NSDate class]);
    expect([blockResponseObject valueForKey:@"chambers"]).willNot.beNil();
    expect([blockResponseObject valueForKey:@"terms"]).willNot.beNil();
    expect([blockResponseObject valueForKey:@"sessionDetails"]).willNot.beNil();
}

- (void)testJurisdictionChambers {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSString *ocdId = @"ocd-jurisdiction/country:us/state:hi/legislature";

    [self.client jurisdictionWithId:ocdId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        expect([blockResponseObject valueForKey:@"chambers"]).to.beInstanceOf([NSDictionary class]);
        [[blockResponseObject valueForKey:@"chambers"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDChamber class]);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);

    expect([blockResponseObject valueForKey:@"chambers"]).will.beInstanceOf([NSDictionary class]);
}

- (void)testJurisdictionTerms {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSString *ocdId = @"ocd-jurisdiction/country:us/state:hi/legislature";

    [self.client jurisdictionWithId:ocdId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"terms"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beInstanceOf([OCDTerm class]);
            expect([obj valueForKey:@"name"]).notTo.beNil();
            expect([obj valueForKey:@"sessions"]).notTo.beNil();
            expect([obj valueForKey:@"startYear"]).notTo.beNil();
            expect([obj valueForKey:@"endYear"]).notTo.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);

    expect([blockResponseObject valueForKey:@"terms"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"terms"]).willNot.beEmpty();
}

- (void)testJurisdictionSessionDetails {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSString *ocdId = @"ocd-jurisdiction/country:us/state:hi/legislature";

    [self.client jurisdictionWithId:ocdId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDJurisdiction class]);

    expect([blockResponseObject valueForKey:@"sessionDetails"]).will.beKindOf([NSDictionary class]);
    expect([blockResponseObject valueForKey:@"sessionDetails"]).willNot.beEmpty();
    XCTFail(@"Need to test contents of sessionDetails");
}


@end
