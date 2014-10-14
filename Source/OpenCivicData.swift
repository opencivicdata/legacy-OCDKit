//
//  OpenCivicData.swift
//  OCDKit
//
//  Created by Daniel Cloud on 10/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import Foundation
import Alamofire

enum OCDRouter: URLRequestConvertible {
    static let baseURLString = "https://api.opencivicdata.org"

    case Object(String, [String: AnyObject]?)
    case Bills([String: AnyObject]?)

    var path: String {
        switch self {
        case .Object(let ocdId, _):
            return "/\(ocdId)/"
        case .Bills(_):
            return "/bills/"
        }
    }

    // MARK: URLRequestConvertible

    var URLRequest: NSURLRequest {

        let URL = NSURL(string: OCDRouter.baseURLString)
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        let encoding = Alamofire.ParameterEncoding.URL

        switch self {
        case .Object(_):
            return mutableURLRequest
        case .Bills(let parameters):
            return encoding.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}

public class OpenCivicData {
    let apiKey:String
    let manager:Alamofire.Manager

    public init(_ apiKey:String) {
        self.apiKey = apiKey

        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["X-APIKEY"] = apiKey

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders

        self.manager = Alamofire.Manager(configuration: configuration)
    }

    func request(URLRequest: URLRequestConvertible) -> Request {
        return self.manager.request(URLRequest)
    }

    public func object(ocdId:String) -> Request {
        return self.request(OCDRouter.Object(ocdId, nil))
    }
    public func bills(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Bills(params))
    }
}
