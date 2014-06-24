//
//  OCDTestsBase.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/22/14.
//
//

#import "OCDTestsBase.h"
#import "OCDTestSettings.h"

@implementation OCDTestsBase

@synthesize client;

- (void)setUp {
    [super setUp];
    [Expecta setAsynchronousTestTimeout:5.0];
    self.client = [OCDClient clientWithKey:kSFAPIKey];
}

- (void)tearDown {
    [super tearDown];
}

@end
