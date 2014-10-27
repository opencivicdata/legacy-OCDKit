// Playground - noun: a place where people can play

import XCPlayground
import Foundation
import OCDKit

XCPSetExecutionShouldContinueIndefinitely()

let mykey = "***REMOVED***"

let ocdkit = OpenCivicData(apiKey: mykey)

let boston = ["lat": 42.358056, "lon": -71.063611]

ocdkit.people(boston)
.responseJSON { (request, _, JSON, error) in
    println(request.URLString)
    println(JSON)

    if (error != nil) {
        println("Encountered an error: \(error)")
    }
    else {
        var results: NSArray? = JSON?["results"] as? NSArray
        var meta: NSDictionary? = JSON?["meta"] as? NSDictionary
        var errorMessage: String? = JSON?["error"] as? String
        if let results: NSArray = results {
            for item in results {
                println("Item")
            }
        }
        else {
            println("No results!")
            if let errorMessage:String = errorMessage {
                println(errorMessage)
            }
        }
    }
}

ocdkit.jurisdictions()
.responseJSON { (request, _, JSON, error) in
    println(request.URLString)
    var results: NSArray? = JSON?["results"] as? NSArray
    var meta: NSDictionary? = JSON?["meta"] as? NSDictionary
    var errorMessage: String? = JSON?["error"] as? String

    if let resultsList: NSArray = results {
        println("Found \(resultsList.count) results")
        for item in resultsList {
            if let itemDict = item as? NSDictionary {
                println(itemDict["name"])
            }
        }
    }
    else if let errorMessage = errorMessage {
        println(errorMessage)
    }
}

ocdkit.bills(["from_organization": "ocd-organization/88544b41-d989-46ce-86fb-7ac228beb625"])
    .responseJSON { (request, _, JSON, error) in
        println(request.URLString)
        var results: NSArray? = JSON?["results"] as? NSArray
        var meta: NSDictionary? = JSON?["meta"] as? NSDictionary
        var errorMessage: String? = JSON?["error"] as? String

        if let metaData: NSDictionary = meta {
            if let total_count: Int = metaData["total_count"] as? Int {
                println("Found \(total_count) items in total")
            }
        }

        if let resultsList: NSArray = results {
            println("Found \(resultsList.count) results")
            for item in resultsList {
                if let itemDict = item as? NSDictionary {
                    println(itemDict["name"])
                }
            }
        }
        else if let errorMessage = errorMessage {
            println(errorMessage)
        }

    
}
