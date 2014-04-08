//
//  OCDBillTableViewCell.m
//  OCDKitDemo
//
//  Created by Daniel Cloud on 4/7/14.
//  Copyright (c) 2014 Sunlight Foundation. All rights reserved.
//

#import "OCDTableViewCell.h"
#import "OCDStyle.h"

@implementation OCDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.numberOfLines = 3;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.textColor = [OCDStyle bodyTextColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
