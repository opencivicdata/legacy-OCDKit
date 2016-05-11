
//  configure.swift
//
//  Configure framework for testing. We need an API Key.
//
//  Created by Daniel Cloud on 10/29/14.



import Foundation

let configuration = NSMutableDictionary()

for arg in Process.arguments {
   var components = arg.componentsSeparatedByString("=")
   if components.count == 2 {
      configuration[components[0]] = components[1]
   }
}

var plistData = NSData()

do {
   plistData = try NSPropertyListSerialization.dataWithPropertyList(configuration, format: NSPropertyListFormat.XMLFormat_v1_0, options: 0)
} catch let error as NSError {
   print(error)
}

let fileManager = NSFileManager.defaultManager()
let path = "./Configuration.plist"
let fileURL = NSURL(fileURLWithPath:path)
let resolvedPath = fileURL.path!

if fileManager.fileExistsAtPath(resolvedPath) {
   
   print("Old \(path) exists. Deleting.")
   
   do {
      try fileManager.removeItemAtURL(fileURL)
   } catch let error as NSError {
      print("Unable to delete old version of file.")
      print(error)
   }
}

let result = fileManager.createFileAtPath(resolvedPath, contents: plistData, attributes: nil)

let statusString = result ? "'\(resolvedPath)' successfully created!" : "Unable to create configuration file."

print(statusString)