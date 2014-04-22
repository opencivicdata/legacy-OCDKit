//
//  OCDTestsBase.h
//  OCDKitTest
//
//  Created by Daniel Cloud on 4/22/14.
//
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import "OCDClient.h"

@interface OCDTestsBase : XCTestCase

@property (nonatomic, strong) OCDClient *client;

@end
