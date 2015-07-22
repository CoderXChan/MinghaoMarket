//
//  MyButton.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize goods,starGoods,trueStarGoods,menuGoods,flashGoods;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



@end
