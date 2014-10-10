//
//  OCDKitTests.swift
//  OCDKitTests
//
//  Created by Daniel Cloud on 10/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import XCTest
import OCDKit

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
    
    func testBillSubjectLookup() {
        let api = OpenCivicData(self.apiKey!)
        var request = api.bills(["subject":"LABOR"])

        XCTAssertNotNil(request.request, "request should not be nil")
        XCTAssertEqual(request.request.URL, NSURL(string: "https://api.opencivicdata.org/bills/?subject=LABOR"), "request URL should be equal")
        println(request.request.URL)
        XCTAssertNil(request.response, "response should be nil")

//        XCTAssertEqual(request.description, "GET https://api.opencivicdata.org/bills/?subject=LABOR", "incorrect request description")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
