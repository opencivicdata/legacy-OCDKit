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

        let bundle = NSBundle(forClass: OCDKitTests.self)
        if let configPath = bundle.pathForResource("Configuration", ofType: "plist") {
            let properties = NSDictionary(contentsOfFile: configPath)

            if let apiKey:String = properties?.valueForKey("OCD_API_KEY") as? String {
                self.apiKey = apiKey
            }

        } else {
            // This probably won't occur since there should be an error in the Copy Plist File build phase.
            assertionFailure("You must have a Configuration.plist with OCD_API_KEY set to run tests.")
        }


    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testApiKey() {
        let api = OpenCivicData(apiKey: self.apiKey!)
        XCTAssertNotNil(api.apiKey?, "After setting apiKey, it should not be nil")
    }

    func testKeylessApiFail() {
        let api = OpenCivicData()
        XCTAssertNil(api.apiKey?, "When using default initializer, apiKey should be nil")

        let expectation = expectationWithDescription("OpenCivicData without an api key should fail to get results and instead return an error")

        api.bills()
           .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertEqual(request.URL, NSURL(string: "https://api.opencivicdata.org/bills/")!, "request URL should be equal")
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

    func testBillSubjectSearch() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("Bills Subject Lookup")

        api.bills(["subject":"LABOR"])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertEqual(request.URL, NSURL(string: "https://api.opencivicdata.org/bills/?subject=LABOR")!, "request URL should be equal")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    XCTAssertNotNil(responseDict["meta"], "response dictionary should contain meta")
                    if let metaDict = responseDict["meta"] as? NSDictionary {
                        XCTAssertNotNil(metaDict["count"], "meta dictionary should contain count")
                    }
                    XCTAssertNotNil(responseDict["results"], "response dictionary should contain results")
                    if let resultsArray = responseDict["results"] as? NSArray {
                        XCTAssertGreaterThanOrEqual(resultsArray.count, 0, "results should be some number, right?")
                        for result:AnyObject in resultsArray {
                            if let resultObject = result as? NSDictionary {
                                XCTAssertNotNil(resultObject["id"], "A result object should have an id.")
                            }
                        }
                    }
                }
            }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSwiftyBillSubjectSearch() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("Bills Subject Lookup")

        api.bills(["subject":"LABOR"])
            .responseSwiftyJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertEqual(request.URL, NSURL(string: "https://api.opencivicdata.org/bills/?subject=LABOR")!, "request URL should be equal")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertNotEqual(JSON["meta"].dictionaryValue, [:], "meta dictionary should not be empty")
                XCTAssertNotNil(JSON["meta"]["count"].number, "meta dictionary should contain count")
                XCTAssertNotEqual(JSON["results"].arrayValue, [], "response dictionary should not be empty")

                XCTAssertGreaterThanOrEqual(JSON["results"]["count"].intValue, 0, "results should be some number, right?")
                for result in JSON["results"].arrayValue {
                    XCTAssertNotEqual(result["id"].stringValue, "", "A result object should have an id.")
                }
        }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testRouterForObject() {
        let ocdId = "ocd-bill/000040f9-c09a-4121-aa08-4049fcb9d440";
        var route = OCDRouter.Object(ocdId, nil)
        XCTAssertEqual(route.URLRequest.URL, NSURL(string: "https://api.opencivicdata.org/\(ocdId)/")!, "request URL should be equal")
    }

    func testRouterForSearch() {
        let path = "foo"
        var route = OCDRouter.Search(path, nil)
        XCTAssertEqual(route.URLRequest.URL, NSURL(string: "https://api.opencivicdata.org/\(path)/")!, "request URL should be equal")
    }

    func testRouterForSearchWithParameters() {
        let path = "bills"
        var route = OCDRouter.Search(path, ["subject":"LABOR"])
        XCTAssertEqual(route.URLRequest.URL, NSURL(string: "https://api.opencivicdata.org/\(path)/?subject=LABOR")!, "request URL should be equal")
    }

    func testObjectLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("OCD Object Lookup")
        let ocdId = "ocd-bill/000040f9-c09a-4121-aa08-4049fcb9d440";

        api.object(ocdId)
            .responseJSON { (request, response, _, error) in
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

    func testObjectLookupWithParameters() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("OCD Object Lookup")
        let ocdId = "ocd-bill/000040f9-c09a-4121-aa08-4049fcb9d440";
        let fieldnames = ["title", "updated_at"]
        let parameters = ["fields": ",".join(fieldnames)]

        api.object(ocdId)
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                XCTAssertEqual(request.URL, NSURL(string: "https://api.opencivicdata.org/\(ocdId)/")!, "request URL should be equal")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    for field in fieldnames {
                        XCTAssertNotNil(responseDict[field], "response dictionary should contain \(field)")
                    }
                }
                else {
                    XCTFail("Object should have a response as an NSDictionary")
                }
        }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testPeopleLatLonLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("People Lat/Lon Lookup")

        let lat =  42.358056
        let lon = -71.063611

        api.people(["lat": lat, "lon": lon])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                var requestString: String? = request.URL.absoluteString
                XCTAssert(requestString?.hasPrefix("https://api.opencivicdata.org/people/") != nil, "request URL should start with api.opencivicdata.org/people/")
                let latParam = "lat=\(lat)"
                XCTAssert(requestString?.rangeOfString(latParam) != nil, "request URL should contain lat")
                let lonParam = "lon=\(lon)"
                XCTAssert(requestString?.rangeOfString(lonParam) != nil, "request URL should contain lon")
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    XCTAssertNotNil(responseDict["meta"], "response dictionary should contain meta")
                    if let metaDict = responseDict["meta"] as? NSDictionary {
                        XCTAssertNotNil(metaDict["count"], "meta dictionary should contain count")
                    }
                    XCTAssertNotNil(responseDict["results"], "response dictionary should contain results")
                    if let resultsArray = responseDict["results"] as? NSArray {
                        XCTAssertGreaterThanOrEqual(resultsArray.count, 0, "results should be some number, right?")
                        for result:AnyObject in resultsArray {
                            if let resultObject = result as? NSDictionary {
                                XCTAssertNotNil(resultObject["id"], "A result object should have an id.")
                            }
                        }
                    }
                }
        }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}
