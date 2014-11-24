//
//  OCDFieldsTests.swift
//  OCDKit
//
//  Created by Daniel Cloud on 11/24/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import XCTest

class OCDFieldsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - Default Fields Tests

    func testDefaultFieldsForObject() {
        let fields: [String] = OCDFields.Object.defaultFields
        let expectedFields: [String] = ["id"]
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Object should include only \"id\"")
    }

    func testDefaultFieldsForBill() {
        let fields: [String] = OCDFields.Bill.defaultFields
        let expectedFields: [String] = ["id", "created_at", "updated_at", "identifier", "legislative_session_id", "title", "from_organization_id", "classification"]
        let expectedFieldStr: String = join(", ", expectedFields)
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Bill should include \"\(expectedFieldStr)\"")
    }

    func testDefaultFieldsForDivision() {
        let fields: [String] = OCDFields.Division.defaultFields
        let expectedFields: [String] = ["id", "name", "country", "jurisdictions"]
        let expectedFieldStr: String = join(", ", expectedFields)
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Division should include \"\(expectedFieldStr)\"")
    }

    func testDefaultFieldsForEvent() {
        let fields: [String] = OCDFields.Event.defaultFields
        let expectedFields: [String] = ["id", "created_at", "updated_at", "jurisdiction_id", "description", "classification", "start_time", "end_time", "timezone"]
        let expectedFieldStr: String = join(", ", expectedFields)
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Event should include \"\(expectedFieldStr)\"")
    }

    func testDefaultFieldsForJurisdiction() {
        let fields: [String] = OCDFields.Jurisdiction.defaultFields
        let expectedFields: [String] = ["id", "classification", "url"]
        let expectedFieldStr: String = join(", ", expectedFields)
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Jurisdiction should include \"\(expectedFieldStr)\"")
    }

    func testDefaultFieldsForPerson() {
        let fields: [String] = OCDFields.Person.defaultFields
        let expectedFields: [String] = ["id", "created_at", "updated_at", "name", "image", "summary", "birth_date", "other_names"]
        let expectedFieldStr: String = join(", ", expectedFields)
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Person should include \"\(expectedFieldStr)\"")
    }

    func testDefaultFieldsForVote() {
        let fields: [String] = OCDFields.Vote.defaultFields
        let expectedFields: [String] = ["id", "created_at", "updated_at", "identifier", "motion_text", "start_date", "end_date", "organization_id", "bill_id", "result"]
        let expectedFieldStr: String = join(", ", expectedFields)
        XCTAssertEqual(fields, expectedFields, "Default fields for OCDFields.Vote should include \"\(expectedFieldStr)\"")
    }

}
