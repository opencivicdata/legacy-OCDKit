//
//  OCDTestsBase.swift
//  OCDKit
//
//  Created by Daniel Cloud on 11/24/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import UIKit
import XCTest
import OCDKit // Not really necessary as OCDKit is a member of the test target

class OCDTestsBase: XCTestCase {
    var apiKey: String?
    let longTimeOut: NSTimeInterval = 30
    let shortTimeOut: NSTimeInterval = 10

    override func setUp() {
        super.setUp()

        let bundle = NSBundle(forClass: OCDTestsBase.self)
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

    func testSetUp() {
        XCTAssertNotNil(self.apiKey, "OCDTestsBase.apiKey should not be nil")
    }

}
