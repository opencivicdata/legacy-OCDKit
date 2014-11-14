//
//  Configuration.swift
//  OCDKitExample
//
//  Created by Daniel Cloud on 11/14/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import Foundation

class Configuration {
    let bundle = NSBundle.mainBundle()
    var properties:Dictionary<String, AnyObject> = [:]

    init() {
        if let configPath:String = bundle.pathForResource("Configuration", ofType: "plist") {
            let propDict = NSDictionary(contentsOfFile: configPath)
            if let properties = propDict as? Dictionary<String, AnyObject> {
                self.properties = properties
            }

        } else {
            // This probably won't occur since there should be an error in the Copy Plist File build phase.
            assertionFailure("You must have a Configuration.plist with OCD_API_KEY set to run tests.")
        }
    }

}