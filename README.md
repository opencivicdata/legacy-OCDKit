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
```

We include [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) support if you don't want to handle unwrapping NSDictionary and NSArray optionals:

```swift
ocdkit.bills()
      .responseSwiftyJSON { (request, response, json, error) in
        println(request.URLString)
        var meta = json["meta"].dictionaryValue
        var results = json["results"].arrayValue
        for item in results {
            println(item["from_organization"]["name"])
        }
        println(error)
}
```

## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 6.1


## Installation

*Coming soon.*

- Install Alamofire-SwiftyJSON submodule `git submodule init` and `git submodule update`

## Running Tests

For tests to run, you need to create a Configuration.plist with a value for OCD_API_KEY. You can create this on the command line by running `xcrun swift configure.swift` with a `key=value` argument. For example, if you have a SUNLIGHT_KEY environment variable set you can run:

```
xcrun swift ./configure.swift OCD_API_KEY=$SUNLIGHT_KEY
```

This will create a `Configuration.plist` file in the same directory as the script. You should move this into `Tests/Supporting Files/`.

## Running the Demo

Similar to the tests, you need to supply a `Configuration.plist` containing an OCD_API_KEY. Run `xcrun swift ./configure.swift OCD_API_KEY=$SUNLIGHT_KEY` and place the resulting file in `Example/OCDKitExample/Resources/Supporting\ Files`.
