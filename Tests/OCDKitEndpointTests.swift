//
//  OCDKitEndpointTests.swift
//  OCDKit
//
//  Created by Daniel Cloud on 11/24/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import XCTest
import SwiftyJSON


// MARK: - Object Lookup Tests

class OCDObjectLookupTests: OCDTestsBase {
    let sampleBillID = "ocd-bill/36ebab81-71b1-476f-9f4a-a565621968e4"

    func testBillObjectLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("OCD Object Lookup")
        let ocdId = sampleBillID;
        let fields = OCDFields.Bill.defaultFields

        api.object(ocdId, fields: fields, parameters: nil)
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")
//                let json = SwiftyJSON.JSON(JSON!)
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    for f in fields {
                        XCTAssertNotNil(responseDict[f], "response dictionary should contain \(f)")
                    }
                }
                else {
                    XCTFail("Object should have a response as an NSDictionary")
                }
        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testObjectLookupWithCustomFields() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("OCD Object Lookup with custom fields")
        let ocdId = sampleBillID;
        let fields = ["title", "updated_at", "identifier"]

        api.object(ocdId, fields: fields, parameters: nil)
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    for f in fields {
                        XCTAssertNotNil(responseDict[f], "response dictionary should contain \(f)")
                    }
                }
                else {
                    XCTFail("Object should have a response as an NSDictionary")
                }
        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testPersonObjectLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("OCD Person Object Lookup")
        let ocdId = "ocd-person/0006efa7-70bf-41a0-8b0b-4bf8f999e7c1/";
        let expectedName = "Stephen R. Archambault"
        let fields = OCDFields.Person.defaultFields

        api.object(ocdId, fields: fields, parameters: nil)
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    for f in fields {
                        XCTAssertNotNil(responseDict[f], "response dictionary should contain \(f)")
                    }
                    let resultName: String = responseDict["name"] as! String
                    XCTAssertEqual(resultName, expectedName, "expect name for person to be \"\(expectedName)\"")
                }
                else {
                    XCTFail("Object should have a response as an NSDictionary")
                }
        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}

// MARK: - Bill Endpoint Tests

class OCDBillEndpointTests: OCDTestsBase {

    func testBillSubjectSearch() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("Bills Subject Lookup")

        let fields = ["id", "title"]

        api.bills(fields: fields, parameters: ["subject":"LABOR"])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")
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
                                for f in fields {
                                    XCTAssertNotNil(resultObject[f], "A result object should have a \"\(f)\" field.")
                                }
                            }
                        }
                    }
                }
        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testBillSearchByOrganization() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("Bills by Organiation ID Lookup")

        let organization_id = "ocd-organization/98004f81-af38-4600-82a9-d1f23200be0b"
        let fields = OCDFields.Bill.defaultFields

        api.bills(fields: fields, parameters: ["from_organization_id": organization_id])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")
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
                                for f in fields {
                                    println("\(f): \(resultObject[f])")
                                    XCTAssertNotNil(resultObject[f], "A result object should have a \"\(f)\" field.")
                                }
                            }
                        }
                    }
                }
        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSwiftyBillSubjectSearch() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("Bills Subject Lookup")

        api.bills(fields: ["id"], parameters: ["subject":"LABOR"])
            .response { (request, response, data, error) in
                expectation.fulfill()

                // Check URL request
                XCTAssertNotNil(request, "request should not be nil")
                println(request.URL)
                XCTAssertNotNil(response, "response should not be nil")

                // Check response
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")

                // Check JSON
                if let jsonData: NSData = data as? NSData {
                    var error:NSError? = nil
                    let object = JSON(data: jsonData)
                    XCTAssertNotEqual(object["meta"], [:], "meta dictionary should not be empty")
                    XCTAssertNotNil(object["meta"]["count"].number, "meta dictionary should contain count")
                    XCTAssertNotEqual(object["results"].arrayValue, [], "response dictionary should not be empty")
                    XCTAssertGreaterThanOrEqual(object["results"]["count"].intValue, 0, "results should be some number, right?")

                    // Check JSON results
//                    for result in json["results"] {
//                        XCTAssertNotEqual(result["id"], "", "A result object should have an id.")
//                    }
                }
        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}

// MARK: - Division Endpoint Tests

class OCDDivisionEndpointTests: OCDTestsBase {

    func testDivisionFetchResults() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("Division Fetch Results")

        api.divisions(fields: OCDFields.Division.defaultFields, parameters: [:])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()

                self.measureBlock({ _ in
                    if let responseDict = JSON as? NSDictionary {
                        let results = responseDict["results"] as? NSArray
                    }
                })
        }

        waitForExpectationsWithTimeout(longTimeOut, handler: { (error) in
            XCTAssertNil(error, "\(error)")
        })
    }

//    func testSwiftDivisionFetchResults() {
//        let api = OpenCivicData(apiKey: self.apiKey!)
//
//        let expectation = expectationWithDescription("Swifty Division Fetch Results")
//
//        api.divisions(fields: OCDFields.Division.defaultFields, parameters: [:])
//            .responseJSON { (request, response, JSON, error) in
//                expectation.fulfill()
//
//                self.measureBlock({ _ in
//                    let results = JSON["results"]
//                })
//        }
//
//        waitForExpectationsWithTimeout(longTimeOut, handler: { (error) in
//            XCTAssertNil(error, "\(error)")
//        })
//    }

//    func testSwiftDivisionFetchJurisdictions() {
//        let api = OpenCivicData(apiKey: self.apiKey!)
//
//        let expectation = expectationWithDescription("Swifty Division Fetch Jurisdictions")
//
//        api.divisions(fields: OCDFields.Division.defaultFields, parameters: [:])
//            .responseJSON { (request, response, JSON, error) in
//                expectation.fulfill()
//
//                self.measureBlock({ _ in
//                    for division in JSON["results"] {
//                        let jurisdictions = division["jurisdictions"]
//                        for item in jurisdictions {
//                            println(item["id"])
//                        }
//                    }
//                })
//        }
//
//        waitForExpectationsWithTimeout(longTimeOut, handler: { (error) in
//            XCTAssertNil(error, "\(error)")
//        })
//    }

    func testSwiftyDivisionGeoSearch() {
        let latitude: Double = 42.358056
        let longitude: Double = -71.063611

        let api = OpenCivicData()
        api.apiKey = self.apiKey

        let expectation = expectationWithDescription("Division Lat/Lon Lookup")

        api.divisions(fields: OCDFields.Division.defaultFields, parameters: ["lat": latitude, "lon": longitude])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()

                // Check URL request
                XCTAssertNotNil(request, "request should not be nil")
                var requestString: String? = request.URL!.absoluteString
                XCTAssert(requestString?.hasPrefix("https://api.opencivicdata.org/divisions/") != nil, "request URL should start with api.opencivicdata.org/divisions/")
                // Check lat/lon values were preserved
                let latParam = "lat=\(latitude)"
                XCTAssert(requestString?.rangeOfString(latParam) != nil, "request URL should contain lat")
                let lonParam = "lon=\(longitude)"
                XCTAssert(requestString?.rangeOfString(lonParam) != nil, "request URL should contain lon")

                // Check response
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")

                // Check JSON
//                XCTAssertNotEqual(JSON["meta"], [:], "meta dictionary should not be empty")
//                XCTAssertNotNil(JSON["meta"]["count"], "meta dictionary should contain count")
//                XCTAssertNotEqual(JSON["results"], [], "response dictionary should not be empty")

        }

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}

// MARK: - Jurisdiction Endpoint Tests

class OCDJurisdictionEndpointTests: OCDTestsBase {

    func testJurisdictionLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("OCD Jurisdiction Lookup")
        let division_id = "ocd-division/country:us/state:nc";
        let fields = OCDFields.Jurisdiction.defaultFields

        api.jurisdictions(fields: fields, parameters: ["division_id": division_id])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()

                // Check URL request
                XCTAssertNotNil(request, "request should not be nil")
                var requestString: String? = request.URL!.absoluteString
                XCTAssert(requestString?.hasPrefix("https://api.opencivicdata.org/jurisdictions/") != nil, "request URL should start with api.opencivicdata.org/jurisdictions/")

                // Check response
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")

                // Check JSON
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
                                for f in fields {
                                    println("\(f): \(resultObject[f])")
                                    XCTAssertNotNil(resultObject[f], "A result object should have a \"\(f)\" field.")
                                }
                            }
                        }
                    }
                }
        }
        
        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}

// MARK: - Person Endpoint Tests

class OCDPersonEndpointTests: OCDTestsBase {

    func testPeopleLatLonLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("People Lat/Lon Lookup")

        let lat =  42.358056
        let lon = -71.063611

        api.people(fields: OCDFields.Person.defaultFields, parameters: ["lat": lat, "lon": lon])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()

                // Check URL request
                XCTAssertNotNil(request, "request should not be nil")
                var requestString: String? = request.URL!.absoluteString
                XCTAssert(requestString?.hasPrefix("https://api.opencivicdata.org/people/") != nil, "request URL should start with api.opencivicdata.org/people/")
                let latParam = "lat=\(lat)"
                XCTAssert(requestString?.rangeOfString(latParam) != nil, "request URL should contain lat")
                let lonParam = "lon=\(lon)"
                XCTAssert(requestString?.rangeOfString(lonParam) != nil, "request URL should contain lon")

                // Check response
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")

                // Check JSON
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    // Check JSON meta
                    XCTAssertNotNil(responseDict["meta"], "response dictionary should contain meta")
                    if let metaDict = responseDict["meta"] as? NSDictionary {
                        XCTAssertNotNil(metaDict["count"], "meta dictionary should contain count")
                    }

                    // Check JSON results
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
        
        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }


    func testPeopleMembershipLookup() {
        let api = OpenCivicData(apiKey: self.apiKey!)

        let expectation = expectationWithDescription("People Membership Lookup")

        let division_id = "ocd-organization/98004f81-af38-4600-82a9-d1f23200be0b"

        api.people(fields: OCDFields.Person.defaultFields, parameters: ["member_of": division_id])
            .responseJSON { (request, response, JSON, error) in
                expectation.fulfill()

                // Check URL request
                XCTAssertNotNil(request, "request should not be nil")
                var requestString: String? = request.URL!.absoluteString
                XCTAssert(requestString?.hasPrefix("https://api.opencivicdata.org/people/") != nil, "request URL should start with api.opencivicdata.org/people/")

                // Check response
                XCTAssertNotNil(response, "response should not be nil")
                XCTAssertLessThan(response!.statusCode, 500, "Response status code should not be 500 or above")

                // Check JSON
                XCTAssertNotNil(JSON, "JSON should not be nil")
                if let responseDict = JSON as? NSDictionary {
                    // Check JSON meta
                    XCTAssertNotNil(responseDict["meta"], "response dictionary should contain meta")
                    if let metaDict = responseDict["meta"] as? NSDictionary {
                        XCTAssertNotNil(metaDict["count"], "meta dictionary should contain count")
                    }

                    // Check JSON results
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

        waitForExpectationsWithTimeout(longTimeOut) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}
