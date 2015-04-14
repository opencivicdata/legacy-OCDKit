//
//  OCDKitTests.swift
//  OCDKitTests
//
//  Created by Daniel Cloud on 10/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import XCTest

// MARK: - OpenCivicData Basic Tests

class OCDKitBasicTests: OCDTestsBase {

    func testApiKey() {
        let api = OpenCivicData(apiKey: self.apiKey!)
        XCTAssertNotNil(api.apiKey, "After setting apiKey, it should not be nil")
    }

    func testKeylessApiFail() {
        let api = OpenCivicData()
        XCTAssertNil(api.apiKey, "When using default initializer, apiKey should be nil")

        let expectation = expectationWithDescription("OpenCivicData without an api key should fail to get results and instead return an error")

        api.bills(fields: ["id"], parameters: nil)
           .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    XCTAssertNil(responseDict["meta"], "response dictionary should NOT contain meta")
                    XCTAssertNil(responseDict["results"], "response dictionary should NOT contain results")
                    XCTAssertNotNil(responseDict["error"], "response dictionary should contain error")
                    if let responseError: String = responseDict["error"] as? String {
                        XCTAssert(responseError.hasPrefix("Authorization Required"), "Should get an 'Authorization Required' message")
                    }
                }
            }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}

// MARK: - Router Tests

class OCDRouterTests: OCDTestsBase {

    func testRouterForObject() {
        let ocdId = "ocd-bill/000040f9-c09a-4121-aa08-4049fcb9d440";
        let fields = ["id"]
        let paramString = join(",", fields)
        var route = OCDRouter.Object(ocdId, fields, nil)
        XCTAssertEqual(route.URLRequest.URL!, NSURL(string: "https://api.opencivicdata.org/\(ocdId)/?fields=\(paramString)")!, "request URL should be equal")
    }

    func testRouterForSearch() {
        let path = "foo"
        let fields = ["id"]
        let paramString = join(",", fields)
        var route = OCDRouter.Search(path, fields, nil)
        XCTAssertEqual(route.URLRequest.URL!, NSURL(string: "https://api.opencivicdata.org/\(path)/?fields=\(paramString)")!, "request URL should be equal")
    }

    func testRouterForSearchWithParameters() {
        let path = "bills"
        let fields = ["id"]
        let paramString = join(",", fields)
        var route = OCDRouter.Search(path, fields, ["subject":"LABOR"])
        XCTAssertEqual(route.URLRequest.URL!, NSURL(string: "https://api.opencivicdata.org/\(path)/?fields=\(paramString)&subject=LABOR")!, "request URL should be equal")
    }

}

