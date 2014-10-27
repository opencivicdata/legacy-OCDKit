OCDKit
======

A Swift framework for the Open Civic Data API.


```swift
let ocdkit = OpenCivicData(apiKey: "YOUR_API_KEY")
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
```

## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 6.1


## Installation

*Coming soon.*