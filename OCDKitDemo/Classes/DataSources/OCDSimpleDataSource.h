//
//  OCDSimpleDataSource.h
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCDSimpleDataLoader <NSObject>

- (void)loadDataWithCompletion:(void (^)(BOOL success))completionBlock;

@end

@interface OCDSimpleDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *rows;

@end
