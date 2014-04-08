//
//  OCDBillsTableDataSource.h
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDSimpleDataSource.h"

@interface OCDBillsTableDataSource : OCDSimpleDataSource <OCDSimpleDataLoader>

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock;

@end
