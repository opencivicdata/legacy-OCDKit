// Playground - noun: a place where people can play

import XCPlayground
import Foundation
import OCDKit

XCPSetExecutionShouldContinueIndefinitely()

let mykey = "API_KEY_HERE"

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
        var results:NSArray? = JSON?["results"] as? NSArray
        var meta:NSDictionary? = JSON?["meta"] as? NSDictionary
        var errorMessage:String? = JSON?["error"] as? String
        if let results:NSArray = results {
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

ocdkit.jurisdictions(["division_id":"ocd-division/country:us/state:wi"])
.responseJSON { (_, _, JSON, error) in
    var results:NSArray? = JSON?["results"] as? NSArray
    var meta:NSDictionary? = JSON?["meta"] as? NSDictionary
    var errorMessage:String? = JSON?["error"] as? String

    if let resultsList:NSArray = results {
        println("Found \(resultsList.count) results")
    }
    else if let errorMessage = errorMessage {
        println(errorMessage)
    }
}
