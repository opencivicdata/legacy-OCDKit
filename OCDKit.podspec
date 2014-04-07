Pod::Spec.new do |s|

  s.name         = "OCDKit"
  s.version      = "0.0.1"
  s.summary      = "An Objective-C framework for the Open Civic Data API."

  s.description  = <<-DESC
                   An Objective-C framework for the Open Civic Data API.

                   A longer description of OCDKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://opencivicdata.org/"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Jeremy Carbaugh" => "jcarbaugh@sunlightfoundation.com",
                     "Daniel Cloud" => "dcloud@sunlightfoundation.com" }


  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/sunlightlabs/OCDKit.git", :tag => "0.0.1" }
  s.source_files  = "OCDKit"
  # s.public_header_files = "OCDKit/*.h"
  s.exclude_files = "InstagramKitDemo"

  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.dependency "AFNetworking/NSURLSession", "~> 2.2.0"
  s.dependency "Mantle", "~> 1.4.0"

end
