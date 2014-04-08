//
//  OCDStyles.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/8/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDStyle.h"

@implementation OCDStyle

#pragma mark - Public methods

+ (UIColor *)bodyTextColor {
    return [UIColor colorWithWhite:0.302 alpha:1.000];
}

+ (UIColor *)highlightColorBright {
    return [UIColor colorWithRed:0.851 green:0.878 blue:0.129 alpha:1.000];
}

+ (UIColor *)highlightColorDark {
    return [UIColor colorWithRed:0.490 green:0.553 blue:0.039 alpha:1.000];
}

+ (UIColor *)lightGrey {
    return [UIColor colorWithRed:0.957 green:0.953 blue:0.937 alpha:1.000];
}

+ (UIColor *)darkGrey {
    return [UIColor colorWithRed:0.311 green:0.310 blue:0.303 alpha:1.000];
}

+ (void)setUpAppearance {
    [UIView appearance].tintColor = [self highlightColorDark];
    [UINavigationBar appearance].tintColor = [self highlightColorDark];
    [UINavigationBar appearance].barTintColor = [self lightGrey];
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName: [self highlightColorDark] };
    [UILabel appearance].textColor = [self bodyTextColor];

}

@end
