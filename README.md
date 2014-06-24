# OCDKit

An Objective-C framework for the [Open Civic Data API](http://docs.opencivicdata.org/en/latest/api/index.html).

## Making Requests

    OCDClient client = [OCDClient clientWithKey:@"this-is-my-key"];
    OCDResultSet result = [client bills:@{}];
    NSLog(@"Results: %@", result.items)

## Demo

A demo app lives in the *OCDKitDemo* directory. To run:

```bash
$ cd OCDKitDemo/
$ pod install
$ open OCDKitDemo.xcworkspace
```

There are no tests on the demo, but...

## Testing

Unit tests are in the *Tests* directory and integrate with CocoaPods.

```bash
$ cd Tests/
$ pod install
$ open OCDKitTest.xcworkspace
```