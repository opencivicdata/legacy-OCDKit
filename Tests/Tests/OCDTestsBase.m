//
//  OCDTestsBase.m
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/22/14.
//
//

#import "OCDTestsBase.h"

@implementation OCDTestsBase

@synthesize client;

- (void)setUp {
    [super setUp];
    [Expecta setAsynchronousTestTimeout:5.0];
    self.client = [OCDClient clientWithKey:@"***REMOVED***"];
}

- (void)tearDown {
    [super tearDown];
}

@end
