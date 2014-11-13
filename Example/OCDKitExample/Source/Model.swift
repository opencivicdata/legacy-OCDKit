//
//  Model.swift
//  OCDKitExample
//
//  Created by Daniel Cloud on 11/13/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import Foundation

enum OCDType {
    case Bill
    case Division
    case Event
    case Jurisdiction
    case Person
    case Vote

    func label() -> String {
        switch self {
        case .Bill:
            return "Bill"
        case .Division:
            return "Division"
        case .Event:
            return "Event"
        case .Jurisdiction:
            return "Jurisdiction"
        case .Person:
            return "Person"
        case .Vote:
            return "Vote"
        }

    }
}