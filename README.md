# OCDKit

An Objective-C framework for the [Open Civic Data API](http://docs.opencivicdata.org/en/latest/api/index.html).

## Making Requests

    OCDClient client = [OCDClient clientWithKey:@"this-is-my-key"];
    OCDResultSet result = [client bills:@{}];
    NSLog(@"Results: %@", result.items)
    