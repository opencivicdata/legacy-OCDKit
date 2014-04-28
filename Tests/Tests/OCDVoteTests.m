//
//  OCDVoteTests.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/28/14.
//
//

#import "OCDTestsBase.h"
#import "OCDVote.h"
#import "OCDBill.h"

@interface OCDVoteTests : OCDTestsBase

@property (nonatomic, strong) NSString *stubOCDId;

@end

@implementation OCDVoteTests

- (void)setUp
{
    [super setUp];
    self.stubOCDId = @"ocd-vote/6e8155d8-5eb2-11e3-bc39-1231391cd4ec";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetVote {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    NSURLSessionDataTask *task = [self.client voteWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    expect(blockResponseObject).will.beInstanceOf([OCDVote class]);
}

- (void)testVoteExpectedFields {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client voteWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDVote class]);

    expect([blockResponseObject valueForKey:@"ocdId"]).will.equal(self.stubOCDId);
    expect([blockResponseObject valueForKey:@"organizationId"]).will.equal(@"ocd-organization/b0ab4e00-3bf3-11e3-ac3c-1231391cd4ec");
    expect([blockResponseObject valueForKey:@"session"]).will.beKindOf([NSString class]);
    expect([blockResponseObject valueForKey:@"chamber"]).will.equal(OCDChamberTypeUnknown);
    expect([blockResponseObject valueForKey:@"date"]).will.beKindOf([NSDate class]);
    expect([blockResponseObject valueForKey:@"motion"]).will.beKindOf([NSString class]);
    expect([blockResponseObject valueForKey:@"type"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"passed"]).will.beFalsy();
    expect([blockResponseObject valueForKey:@"bill"]).will.beKindOf([OCDBill class]);
    expect([blockResponseObject valueForKey:@"voteCounts"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"rollCall"]).will.beKindOf([NSArray class]);
}

- (void)testVoteType {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client voteWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"type"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([NSNumber class]);
            expect(obj).toNot.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDVote class]);

    expect([blockResponseObject valueForKey:@"type"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"type"]).willNot.beEmpty(); // type actually can be empty
}

- (void)testVoteCounts {
    __block id blockResponseObject = nil;
    __block id blockError = nil;

    [self.client voteWithId:self.stubOCDId fields:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        blockResponseObject = responseObject;
        [[responseObject valueForKey:@"voteCounts"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            expect(obj).to.beKindOf([OCDVoteCount class]);
            expect([obj valueForKey:@"count"]).to.to.beGreaterThanOrEqualTo(0);
            expect([obj valueForKey:@"voteValue"]).to.beKindOf([NSNumber class]);
            expect(obj).toNot.beNil();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        blockError = error;
    }];

    //    Check the response
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil();
    expect(blockResponseObject).will.beInstanceOf([OCDVote class]);

    expect([blockResponseObject valueForKey:@"voteCounts"]).will.beKindOf([NSArray class]);
    expect([blockResponseObject valueForKey:@"voteCounts"]).willNot.beEmpty(); // type actually can be empty
}

@end
