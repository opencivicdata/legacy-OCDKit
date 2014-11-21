//
//  OpenCivicData.swift
//  OCDKit
//
//  Created by Daniel Cloud on 10/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

public typealias URLParameters = [String:AnyObject]

// MARK: - OCDRouter

enum OCDRouter: URLRequestConvertible {
    static let baseURLString = "https://api.opencivicdata.org"

    case Object(String, [String], URLParameters?)
    case Search(String, [String], URLParameters?)

    var path: String {
        switch self {
        case .Object(let ocdId, _, _):
            return "/\(ocdId)/"
        case .Search(let endpoint, _, _):
            return "/\(endpoint)/"
        }

    }

    // MARK: URLRequestConvertible

    var URLRequest: NSURLRequest {

        let URL = NSURL(string: OCDRouter.baseURLString)
        let mutableURLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
        let encoding = Alamofire.ParameterEncoding.URL

        func mergeFieldsParameters(fields: [String], params: URLParameters?) -> URLParameters {
            var URLParams: URLParameters = [:]
            URLParams["fields"] = join(",", fields)
            if var params = params {
                for (key, value) in params {
                    var v: AnyObject = value
                    if let value = params[key] as? Double {
                        v = "\(Double(value))"
                    }
                    URLParams[key] = v

                }
            }
            return URLParams
        }

        let parameters: URLParameters = {
            switch self {
                case .Object(_, let fields, let params):
                    return mergeFieldsParameters(fields, params)
                case .Search(_, let fields, let params):
                    return mergeFieldsParameters(fields, params)
                }

        }()

        return encoding.encode(mutableURLRequest, parameters: parameters).0
    }
}

// MARK: - OpenCivicData

/// API Wrapper for the OpenCivicData API
public class OpenCivicData {
    /// The API Key for the OpenCivicData API
    public var apiKey:String? {
        didSet {
            self.configureManager()
        }
    }
    /// Manager for the NSURLSession configuration
    private var manager:Alamofire.Manager = Alamofire.Manager(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    public init() {}

    /**
    Convenience initializer which sets the apiKey and configures the manager to add X-APIKEY to the session HTTP headers

    :param: apiKey An OpenCivicData API Key

    :returns: An instance of OpenCivicData configured with an API key.
    */
    public convenience init(apiKey:String) {
        self.init()
        self.apiKey = apiKey
        self.configureManager()
    }

    /// Configure the manager if an apiKey has been set
    private func configureManager() {
        if let key = self.apiKey {
            var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
            defaultHeaders["X-APIKEY"] = key

            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.HTTPAdditionalHeaders = defaultHeaders

            self.manager = Alamofire.Manager(configuration: configuration)
        }
    }

    /// Internal handler for requests that uses the configured manager
    private func request(URLRequest: URLRequestConvertible) -> Request {
        return self.manager.request(URLRequest)
    }

    // MARK: -

    /**
    Creates a request for an OpenCivicData object from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/ for details

    :param: ocdId The OCD identifier for the object, as a String
    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func object(ocdId:String, fields: [String]) -> Request {
        return self.object(ocdId, fields: fields, parameters: nil)
    }

    /**
    Creates a request for an OpenCivicData object from the OpenCivicData API.
    
    See http://docs.opencivicdata.org/en/latest/api/ for details

    :param: ocdId The OCD identifier for the object, as a String
    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func object(ocdId:String, fields: [String], parameters: URLParameters?) -> Request {
        return self.request(OCDRouter.Object(ocdId, fields, parameters))
    }

    /**
    Creates a request for bills from the OpenCivicData API.
    
    See http://docs.opencivicdata.org/en/latest/api/search.html#bill-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func bills(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("bills", fields, parameters))
    }

    /**
    Creates a request for divisions from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#division-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func divisions(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("divisions", fields, parameters))
    }

    /**
    Creates a request for events from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#event-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func events(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("events", fields, parameters))
    }

    /**
    Creates a request for jurisdictions from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#jurisdiction-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func jurisdictions(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("jurisdictions", fields, parameters))
    }

    /**
    Creates a request for organizations from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#organization-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func organizations(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("organizations", fields, parameters))
    }

    /**
    Creates a request for people from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#person-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func people(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("people", fields, parameters))
    }

    /**
    Creates a request for votes from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#vote-search for details

    :param: fields An array of field names, as Strings
    :param: [String:AnyObject] A dictionary of filter parameters

    :returns: The created request.
    */
    public func votes(#fields: [String], parameters:URLParameters?) -> Request {
        return self.request(OCDRouter.Search("votes", fields, parameters))
    }
}
