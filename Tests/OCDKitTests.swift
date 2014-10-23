//
//  OCDKitTests.swift
//  OCDKitTests
//
//  Created by Daniel Cloud on 10/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import XCTest
import OCDKit // Not really necessary as OCDKit is a member of the test target

class OCDKitTests: XCTestCase {
    var apiKey: String?

    override func setUp() {
        super.setUp()
        self.apiKey = OCDKitApiKey
        println("OCDKitApiKey: \(OCDKitApiKey)")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBillSubjectSearch() {
        let api = OpenCivicData(self.apiKey!)

        let expectation = expectationWithDescription("Bills Subject Lookup")

        api.bills(["subject":"LABOR"])
            .response { (request, response, _, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertEqual(request.URL, NSURL(string: "https://api.opencivicdata.org/bills/?subject=LABOR")!, "request URL should be equal")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
            }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testRouterForObject() {
        let ocdId = "ocd-bill/000040f9-c09a-4121-aa08-4049fcb9d440";
        var urlconvertible = OCDRouter.Object(ocdId, nil)
        XCTAssertEqual(urlconvertible.URLRequest.URL, NSURL(string: "https://api.opencivicdata.org/\(ocdId)/")!, "request URL should be equal")
    }

    func testObjectLookup() {
        let api = OpenCivicData(self.apiKey!)

        let expectation = expectationWithDescription("OCD Object Lookup")
        let ocdId = "ocd-bill/000040f9-c09a-4121-aa08-4049fcb9d440";

        api.object(ocdId)
            .response { (request, response, _, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertEqual(request.URL, NSURL(string: "https://api.opencivicdata.org/\(ocdId)/")!, "request URL should be equal")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
        }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }


}
