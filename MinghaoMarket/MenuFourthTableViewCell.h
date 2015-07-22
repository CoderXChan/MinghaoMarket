//
//  MenuFourthTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/16.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface MenuFourthTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *menuFourthImage;


@property (strong, nonatomic) IBOutlet UILabel *menuFourthTitle;

@property (strong, nonatomic) IBOutlet UILabel *menuFourthDiscount;


@property (strong, nonatomic) IBOutlet UILabel *menuFouthRestTime;



@property (strong, nonatomic) IBOutlet MyButton *menuFourthBtn;



@end
