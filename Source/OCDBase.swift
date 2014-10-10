//
//  OCDBase.swift
//  OCDKit
//
//  Created by Daniel Cloud on 10/9/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

import Foundation

class OCDBase {
    let createdAt, updatedAt: NSDate
    let id: String
    let extras: [String:AnyObject]

    init(id: String, createdAt: NSDate, updatedAt:NSDate, extras:[String:AnyObject]) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.extras = extras
    }

    init(id: String, createdAt: NSDate, updatedAt:NSDate) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.extras = [String:AnyObject]()
    }
}
