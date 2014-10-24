// Playground - noun: a place where people can play

import UIKit
import Alamofire
import CoreLocation

let URL = NSURL(string: "http://httpbin.org/get")
var request = NSURLRequest(URL: URL!)

let lat: Double =  42.358056
let lon: Double = -71.063611

println("lon is \(lon)")

var parameters:[String:AnyObject] = ["foo": "bar", "lat": lat, "lon": lon]

for key in parameters.keys {
    if let value = parameters[key] as? Double {
        parameters.updateValue("\(Double(value))", forKey: key)
    }
}


let encoding = Alamofire.ParameterEncoding.URL

request = encoding.encode(request, parameters: parameters).0

println("\(request.URL.query!)")

let location:CLLocation = CLLocation(latitude: lat, longitude: lon)

func queryComponents(key: String, value: AnyObject) -> [(String, String)] {
    var components: [(String, String)] = []
    if let dictionary = value as? [String: AnyObject] {
        for (nestedKey, value) in dictionary {
            components += queryComponents("\(key)[\(nestedKey)]", value)
        }
    } else if let array = value as? [AnyObject] {
        for value in array {
            components += queryComponents("\(key)[]", value)
        }
    } else {
        println(value)
        components.extend([(key, "\(value)")])
    }

    return components
}

var components: [(String, String)] = []
for key in sorted(Array(parameters.keys), <) {
    let value: AnyObject! = parameters[key]
    components += queryComponents(key, value)
}

var paramString = join("&", components.map{"\($0)=\($1)"} as [String])

println(paramString)

parameters


