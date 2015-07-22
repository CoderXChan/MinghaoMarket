//
//  SelectionCell.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "SelectionCell.h"

@implementation SelectionCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
