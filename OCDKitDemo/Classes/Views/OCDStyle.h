//
//  OCDStyles.h
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDStyle : NSObject

+ (UIColor *)bodyTextColor;
+ (UIColor *)highlightColorBright;
+ (UIColor *)highlightColorDark;
+ (UIColor *)lightGrey;
+ (UIColor *)darkGrey;

+ (void)setUpAppearance;

@end
