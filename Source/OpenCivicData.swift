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

// MARK: - OCDRouter

enum OCDRouter: URLRequestConvertible {
    static let baseURLString = "https://api.opencivicdata.org"

    case Object(String, [String: AnyObject]?)
    case Search(String, [String: AnyObject]?)

    var path: String {
        switch self {
        case .Object(let ocdId, _):
            return "/\(ocdId)/"
        case .Search(let endpoint, _):
            return "/\(endpoint)/"
        }

    }

    // MARK: URLRequestConvertible

    var URLRequest: NSURLRequest {

        let URL = NSURL(string: OCDRouter.baseURLString)
        let mutableURLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
        let encoding = Alamofire.ParameterEncoding.URL

        switch self {
        case .Object(_):
            return mutableURLRequest
        case .Search(_, let parameters):
            if var params = parameters {
                for (key, value) in params {
                    if let value = params[key] as? Double {
                        params.updateValue("\(Double(value))", forKey: key)
                    }
                }
                return encoding.encode(mutableURLRequest, parameters: params).0
            }
            else {
                return mutableURLRequest
            }
        default:
            return mutableURLRequest
        }
    }
}

// MARK: - OpenCivicData

/// API Wrapper for the OpenCivicData API
public class OpenCivicData {
    /// The API Key for the OpenCivicData API
    var apiKey:String? {
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

    :returns: The created request.
    */
    public func object(ocdId:String) -> Request {
        return self.request(OCDRouter.Object(ocdId, nil))
    }

    /**
    Creates a request for bills from the OpenCivicData API.
    
    See http://docs.opencivicdata.org/en/latest/api/search.html#bill-search for details

    :param: None

    :returns: The created request.
    */
    public func bills() -> Request {
        return self.request(OCDRouter.Search("bills", nil))
    }

    /**
    Creates a request for bills from the OpenCivicData API.
    
    See http://docs.opencivicdata.org/en/latest/api/search.html#bill-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func bills(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("bills", params))
    }

    /**
    Creates a request for divisions from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#division-search for details

    :param: None

    :returns: The created request.
    */
    public func divisions() -> Request {
        return self.request(OCDRouter.Search("divisions", nil))
    }

    /**
    Creates a request for divisions from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#division-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func divisions(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("divisions", params))
    }

    /**
    Creates a request for events from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#event-search for details

    :param: None

    :returns: The created request.
    */
    public func events() -> Request {
        return self.request(OCDRouter.Search("events", nil))
    }

    /**
    Creates a request for events from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#event-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func events(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("events", params))
    }

    /**
    Creates a request for jurisdictions from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#jurisdiction-search for details

    :param: none

    :returns: The created request.
    */
    public func jurisdictions() -> Request {
        return self.request(OCDRouter.Search("jurisdictions", nil))
    }

    /**
    Creates a request for jurisdictions from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#jurisdiction-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func jurisdictions(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("jurisdictions", params))
    }

    /**
    Creates a request for organizations from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#organization-search for details

    :param: None

    :returns: The created request.
    */
    public func organizations() -> Request {
        return self.organizations([:])
    }

    /**
    Creates a request for organizations from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#organization-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func organizations(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("organizations", params))
    }

    /**
    Creates a request for people from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#person-search for details

    :param: None

    :returns: The created request.
    */
    public func people() -> Request {
        return self.people([:])
    }

    /**
    Creates a request for people from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#person-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func people(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("people", params))
    }

    /**
    Creates a request for votes from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#vote-search for details

    :param: None

    :returns: The created request.
    */
    public func votes() -> Request {
        return self.votes([:])
    }

    /**
    Creates a request for votes from the OpenCivicData API.

    See http://docs.opencivicdata.org/en/latest/api/search.html#vote-search for details

    :param: [String:AnyObject] A dictionary of search parameters

    :returns: The created request.
    */
    public func votes(params:[String:AnyObject]) -> Request {
        return self.request(OCDRouter.Search("votes", params))
    }
}
