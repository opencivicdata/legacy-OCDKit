#!/usr/bin/env xcrun swift
//
//  configure.swift
//  
//  Configure framework for testing. We need an API Key.
//
//  Created by Daniel Cloud on 10/29/14.
//
//

import Foundation

var configuration:NSMutableDictionary = NSMutableDictionary()

for arg in Process.arguments {
    var components = arg.componentsSeparatedByString("=")
    if components.count == 2 {
        configuration[components[0]] = components[1]
    }
}

var dataErr = NSErrorPointer()
let plistData = NSPropertyListSerialization.dataWithPropertyList(configuration, format: NSPropertyListFormat.XMLFormat_v1_0, options: 0, error: dataErr)

let fileManager:NSFileManager = NSFileManager.defaultManager()

let path = "Tests/Supporting Files/Configuration.plist"

let fileURL = NSURL(fileURLWithPath:path)

let resolvedPath = fileURL!.path!

var fileDeleted:Bool = true

if fileManager.fileExistsAtPath(resolvedPath) {
    println("Old \(path) exists. Deleting.")
    fileDeleted = fileManager.removeItemAtURL(fileURL!, error: nil)
    if !fileDeleted {
        println("Unable to delete old version of file.")
    }
}

let result:Bool = fileManager.createFileAtPath(resolvedPath, contents: plistData, attributes:nil)

let statusString = result ? "'\(resolvedPath)' successfully created!" : "Unable to create configuration file."

println(statusString)

